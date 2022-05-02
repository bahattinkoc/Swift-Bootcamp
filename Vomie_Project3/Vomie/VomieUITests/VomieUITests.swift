//
//  VomieUITests.swift
//  VomieUITests
//
//  Created by Bahattin Koç on 25.04.2022.
//

import XCTest

final class VomieUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("**** UI TEST ****")
    }
    
    func test_module_movieList_searchBar() {
        app.launch()
        
        app.searchBar.tap()
        app.searchBar.typeText("Harry")
        
        XCTAssertTrue(app.navigationBar.isExist())
        XCTAssertTrue(app.searchBar.isExist())
    }
    
    func test_module_movieDetail_setFavorite() {
        app.launch()
        
        app.searchBar.tap()
        app.searchBar.typeText("Harry")
        
        app.searchBarTableView.staticTexts["Harry Potter and the Philosopher's Stone"].tap()
        XCTAssertTrue(app.searchBarTableView.isExist())
        app/*@START_MENU_TOKEN@*/.images["heart"]/*[[".images[\"love\"]",".images[\"heart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBar.buttons["Movies"].tap()
        
        XCTAssertTrue(app.navigationBar.isExist())
        XCTAssertTrue(app.searchBar.isExist())
    }
    
    func test_module_movieDetail_gotoIMDB() {
        app.launch()
        
        app.searchBar.tap()
        app.searchBar.typeText("Harry")
        
        app.searchBarTableView.staticTexts["Harry Potter and the Philosopher's Stone"].tap()
        
        XCTAssertTrue(app.searchBarTableView.isExist())
        app.imbdImage.tap()
        
        XCTAssertTrue(app.navigationBar.isExist())
        XCTAssertTrue(app.imbdImage.isExist())
    }
}

extension XCUIApplication {
    var nowPlayingCollectionView: XCUIElement {
        collectionViews["nowPlayingCollectionView"]
    }
    
    var upcomingTableView: XCUIElement {
        tables["upcomingTableView"]
    }
    
    var searchBar: XCUIElement {
        searchFields["Search Movie"]
    }
    
    var searchBarTableView: XCUIElement {
        tables["Search results"]
    }
    
    var navigationBar: XCUIElement {
        navigationBars["navigationBar"]
    }
    
    var imbdImage: XCUIElement {
        images["imdbImage"]
    }
}

extension XCUIElement {
    func isExist() -> Bool {
        self.exists
    }
}
