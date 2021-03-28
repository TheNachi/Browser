//
//  BookmarksViewController.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import UIKit

class BookmarksViewController: BaseViewController {
    @IBOutlet weak var bookmarksTableView: UITableView!
    private var viewModel: BookmarksViewModel?
    
    override func viewDidLoad() {
        self.title = "Bookmarks"
        self.bookmarksTableView.delegate = self
        self.bookmarksTableView.dataSource = self
        self.viewModel = BookmarksViewModel()
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = self.viewModel else { return 0}
        return vModel.getBookmarkCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath)
        guard let vModel = self.viewModel else { return UITableViewCell() }
        
        if let bookmarkCell = cell as? BookmarkTableViewCell {
            bookmarkCell.bindViewModel(with: vModel.getBookmarkCellViewModel(index: indexPath.row))
            bookmarkCell.delegate = self
            return bookmarkCell
        }
        
        return cell
    }
}

extension BookmarksViewController: CellDelegate {
    func delete(bookmark: String) {
        guard let vModel = viewModel else { return }
        if vModel.deleteBookmark(string: bookmark) {
            DispatchQueue.main.async {
                self.bookmarksTableView.reloadData()
            }
        }
    }
}
