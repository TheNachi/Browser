//
//  TabModel.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import WebKit

class TabModel {
    let id: String
    let webView: WKWebView
    var url: String?
    
    init(with id: String, webView: WKWebView, url: String?) {
        self.id = id
        self.webView = webView
        self.url = url
    }
}
