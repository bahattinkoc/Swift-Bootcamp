//
//  MovieUpcomingCellTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

import XCTest
@testable import Vomie

final class MovieUpcomingCellTest: XCTestCase {
    var presenter: MovieCellPresenter!
    var view: MovieUpcomingCellViewTest!
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
    
    func test_view_invokes() {
        XCTAssertFalse(view.invokeImage)
        XCTAssertFalse(view.invokeReleaseDate)
        XCTAssertFalse(view.invokeDescription)
        XCTAssertFalse(view.invokeTitle)
        presenter.load()
        XCTAssertTrue(view.invokeImage)
        XCTAssertTrue(view.invokeReleaseDate)
        XCTAssertTrue(view.invokeDescription)
        XCTAssertTrue(view.invokeTitle)
    }
}
