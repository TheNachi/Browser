//
//  BookmarksViewModel.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import Foundation

class BookmarksViewModel {
    private var bookmarks = Bookmark.shared.getBookmarks()
    
    public func getBookmarkCount() -> Int {
        return bookmarks?.count ?? 1
    }
    
    public func getSingleBookMark(index: Int) -> String {
        return bookmarks?[index] ?? "You've not saved any website to bookmark yet!"
    }
    
    public func getBookmarkCellViewModel(index: Int) -> BookmarkCellViewModel {
        return BookmarkCellViewModel(bookmarkedUrl: self.getSingleBookMark(index: index))
    }
    
    public func deleteBookmark(string: String) -> Bool {
        let status = Bookmark.shared.deleteBookmarks(string: string)
        if status {
            bookmarks = Bookmark.shared.getBookmarks()
        }
        return status
    }
}
