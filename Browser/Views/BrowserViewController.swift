//
//  ViewController.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import UIKit
import WebKit

class BrowserViewController: BaseViewController {
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var noTabYetLabel: UILabel!
    @IBOutlet weak var urlTextField: UITextField!
    private var progressView: UIProgressView!
    private var webView: WKWebView?
    private var viewModel: BrowserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabsCollectionView.delegate = self
        self.tabsCollectionView.dataSource = self
        self.viewModel = BrowserViewModel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openWebsite))
    }

    @IBAction func addNewTabs(_ sender: UIButton) {
        guard let vModel = viewModel else { return }
        let newTab = TabModel(with: String(vModel.getTabCount()+1), webView: WKWebView(), url: "https://google.com")
        vModel.updateArrayOfTabs(with: newTab)
        self.noTabYetLabel.isHidden = true
        tabsCollectionView.reloadData()
        
        if vModel.getTabCount() == 1 {
            loadWebView(from: vModel.getCurrentTab(index: 0))
            vModel.changeCurrentIndex(index: 0)
        }
    }
    
    func loadWebView(from tabModel: TabModel) {
        webView = tabModel.webView
        guard let webView = webView,
              let tabUrl = tabModel.url?.fixMissingScheme() else { return }
        
        ContainerView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: ContainerView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: ContainerView.trailingAnchor),
            webView.topAnchor.constraint(equalTo: ContainerView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: ContainerView.bottomAnchor),
            
        ])
        webView.navigationDelegate = self
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goBack = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        let bookmark = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookMarkURL))
        let openBookmarks = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(goToBookmarks))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, goBack, forward, bookmark, openBookmarks, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        if let url = URL(string: tabUrl) {
            webView.load(URLRequest(url: url))
        }
        urlTextField.text = webView.url?.absoluteString
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func bookMarkURL() {
        if let url = webView?.url?.absoluteString {
            let bookMarked = Bookmark.shared.bookmarkWebsite(string: url)
            if bookMarked {
                self.correctDisplayAlert(title: "Success", message: "Successfully Bookmarked")
            } else {
                self.correctDisplayAlert(title: "Error", message: "Has already been bookmarked")
            }
        }
    }
    
    @objc func goToBookmarks() {
        self.performSegue(withIdentifier: "goToBookmarks", sender: self)
    }
    
    @objc func openWebsite() {
        guard let vModel = self.viewModel else { return }
        if var stringTyped = urlTextField.text {
            if stringTyped != "" && stringTyped != "https://" {
                guard let url = URL(string: stringTyped.fixMissingScheme()) else { return }
                if let index = vModel.getCurrentTabIndex() {
                    vModel.getCurrentTab(index: index).url = stringTyped
                }
                webView?.load(URLRequest(url: url))
            } else {
                self.correctDisplayAlert(title: "Error", message: "Please ensure you've entered a website and you've opened a new tab")
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(webView?.estimatedProgress ?? 0)
        }
    }
}

extension BrowserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vModel = self.viewModel else { return 0 }
        return vModel.getTabCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vModel = self.viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabsCollectionViewCell.identifier, for: indexPath)
        
        if let tabCell = cell as? TabsCollectionViewCell {
            tabCell.bindViewModel(with: vModel.getTabCellViewModel(index: indexPath.row))
            return tabCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vModel = self.viewModel else { return }
        vModel.changeCurrentIndex(index: indexPath.row)
        self.loadWebView(from: vModel.getCurrentTab(index: indexPath.row))
    }
}

extension BrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let vModel = self.viewModel else { return }
        urlTextField.text = webView.url?.absoluteString
        if let index = vModel.getCurrentTabIndex() {
            vModel.getCurrentTab(index: index).url = webView.url?.absoluteString
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.correctDisplayAlert(title: "Error", message: "There was a problem loading your website, please confirm it's the correct url and try again")
    }
}

