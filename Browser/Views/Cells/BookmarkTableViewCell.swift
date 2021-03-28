//
//  BookmarkTableViewCell.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    static let identifier = "bookmarkCell"
    @IBOutlet weak var bookmarkLabel: UILabel!
    private var viewModel: BookmarkCellViewModel?
    weak var delegate: CellDelegate?
    
    @IBAction func deleteFromBookmark(_ sender: UIButton) {
        if let vModel = viewModel {
            delegate?.delete(bookmark: vModel.bookmarkedUrl)
        }
    }
    
    func bindViewModel(with viewModel: BookmarkCellViewModel) {
        self.viewModel = viewModel
        bookmarkLabel.text = viewModel.bookmarkedUrl
    }
}

struct BookmarkCellViewModel {
    let bookmarkedUrl: String
}

protocol CellDelegate: class {
    func delete(bookmark: String)
}
