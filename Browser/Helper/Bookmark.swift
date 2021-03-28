//
//  Bookmark.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import Foundation

struct Bookmark {
    static let shared = Bookmark()
    let userDefaults = UserDefaults.standard
    
    func bookmarkWebsite(string: String) {
        var bookmarks: [String] = userDefaults.object(forKey: "BOOKMARK") as? [String] ?? []
        if !bookmarks.contains(string) {
            bookmarks.append(string)
        }
        userDefaults.set(bookmarks, forKey: "BOOKMARK")
    }
    
    func getBookmarks() -> [String]? {
        let bookmarks = userDefaults.object(forKey: "BOOKMARK") as? [String]
        return bookmarks
    }
}
