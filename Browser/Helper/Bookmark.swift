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
    
    func bookmarkWebsite(string: String) -> Bool {
        var bookmarks: [String] = userDefaults.object(forKey: Constants.BOOKMARK.rawValue) as? [String] ?? []
        if !bookmarks.contains(string) {
            bookmarks.append(string)
            userDefaults.set(bookmarks, forKey: Constants.BOOKMARK.rawValue)
            return true
        }
        return false
    }
    
    func getBookmarks() -> [String]? {
        let bookmarks = userDefaults.object(forKey: Constants.BOOKMARK.rawValue) as? [String]
        return bookmarks
    }
    
    func deleteBookmarks(string: String) -> Bool {
        var bookmarks = userDefaults.object(forKey: Constants.BOOKMARK.rawValue) as? [String]
        if let index = bookmarks?.firstIndex(of: string) {
            bookmarks?.remove(at: index)
            userDefaults.set(bookmarks, forKey: Constants.BOOKMARK.rawValue)
            return true
        }
        return false
    }
}
