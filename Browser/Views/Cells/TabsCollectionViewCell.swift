//
//  TabsCollectionViewCell.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {
    static let identifier = "tabCell"
    @IBOutlet weak var tabTitle: UILabel!
    
    func bindViewModel(with viewModel: TabCellViewModel) {
        tabTitle.text = viewModel.tabName
    }
}

struct TabCellViewModel {
    let tabName: String
}
