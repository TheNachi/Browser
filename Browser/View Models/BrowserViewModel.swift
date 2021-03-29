//
//  BrowserViewModel.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import Foundation

class BrowserViewModel {
    private var currentTabIndex: Int?
    private var arrayOfTabs: [TabModel] = [TabModel]()
    
    public func getCurrentTabIndex() -> Int? {
        return currentTabIndex
    }
    
    public func updateArrayOfTabs(with tabModel: TabModel) {
        self.arrayOfTabs.append(tabModel)
    }
    
    public func getTabCount() -> Int {
        return arrayOfTabs.count
    }
    
    public func changeCurrentIndex(index: Int) {
        self.currentTabIndex = index
    }
    
    public func getTabCellViewModel(index: Int) -> TabCellViewModel {
        let tabName = Constants.Tab.rawValue + String(index + 1)
        return TabCellViewModel(tabName: tabName)
    }
    
    public func getCurrentTab(index: Int) -> TabModel {
        return arrayOfTabs[index]
    }
}
