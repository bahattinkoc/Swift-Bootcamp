//
//  SearchedMovieCellTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

import XCTest
@testable import Vomie

final class SearchedMovieCellTest: XCTestCase {
    var presenter: SearchedMovieCellPresenter!
    var view: SearchedMovieCellViewTest!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        
        movie = Movie(id: 1, original_language: "Test", original_title: "Test", overview: "Test", poster_path: "Test", release_date: "Test", vote_average: 0, vote_count: 0)
        view = .init()
        presenter = .init(view: view, movie: movie)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        movie = nil
    }
    
    func test_view_set_title() {
        XCTAssertFalse(view.invokeSetTitle)
        presenter.load()
        XCTAssertTrue(view.invokeSetTitle)
    }
}
