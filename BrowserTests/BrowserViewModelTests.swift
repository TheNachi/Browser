//
//  BrowserTests.swift
//  BrowserTests
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import XCTest
import WebKit
@testable import Browser

class BrowserViewModelTests: XCTestCase {
    let tabs = [
        TabModel(with: "1", webView: WKWebView(), url: "https://www.google.com"),
        TabModel(with: "2", webView: WKWebView(), url: "https://www.yahoo.com"),
    ]
    
    let viewModel = BrowserViewModel()
    
    func testGetTabCount() {
        viewModel.updateArrayOfTabs(with: tabs[0])
        XCTAssertEqual(viewModel.getTabCount(), 1)
        
        viewModel.updateArrayOfTabs(with: tabs[1])
        XCTAssertEqual(viewModel.getTabCount(), 2)
    }
    
    func testGetCurrentTab() {
        viewModel.updateArrayOfTabs(with: tabs[0])
        XCTAssertEqual(viewModel.getCurrentTab(index: 0).url, tabs[0].url)
    }
    
    func testChangeCurrentIndex() {
        viewModel.updateArrayOfTabs(with: tabs[1])
        viewModel.changeCurrentIndex(index: 0)
        XCTAssertEqual(viewModel.getCurrentTabIndex(), 0)
    }

}
