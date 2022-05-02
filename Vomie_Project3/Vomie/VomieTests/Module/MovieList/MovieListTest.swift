//
//  MovieListTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 1.05.2022.
//

import XCTest
@testable import Vomie

final class MovieListTest: XCTestCase {
    var presenter: MovieListPresenter!
    var view: MovieListViewControllerTest!
    var interactor: MovieListInteractorTest!
    var router: MovieListRouter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func test_view_ui_invokes() {
        XCTAssertFalse(view.invokeSetTitle, "It needs to be false, but now its true!")
        XCTAssertFalse(view.invokeSetupTableView, "It needs to be false, but now its true!")
        XCTAssertFalse(view.invokeSetupCollectionView, "It needs to be false, but now its true!")
        XCTAssertFalse(view.invokeSetupSearchController, "It needs to be false, but now its true!")
        XCTAssertFalse(view.invokeSetupPageController, "It needs to be false, but now its true!")
        XCTAssertFalse(view.invokeReloadData, "It needs to be false, but now its true!")
        presenter.viewDidLoad()
        XCTAssertTrue(view.invokeSetTitle, "It needs to be true, but now its false!")
        XCTAssertTrue(view.invokeSetupTableView, "It needs to be true, but now its false!")
        XCTAssertTrue(view.invokeSetupCollectionView, "It needs to be true, but now its false!")
        XCTAssertTrue(view.invokeSetupSearchController, "It needs to be true, but now its false!")
        XCTAssertTrue(view.invokeSetupPageController, "It needs to be true, but now its false!")
        XCTAssertTrue(view.invokeReloadData, "It needs to be true, but now its false!")
    }
    
    func test_presenter_fetch_nowplaying() {
        XCTAssertEqual(presenter.nowPlayingCount(), 5)
        XCTAssertNil(presenter.getNowPlayingMovie(index: 0))
        presenter.fetchMovieNowPlayingOutput(result: .success(MovieListTest.loadMovieFromMock(.nowPlaying)))
        XCTAssertNotEqual(presenter.nowPlayingCount(), 0)
        XCTAssertNotNil(presenter.getNowPlayingMovie(index: 0))
    }
    
    func test_presenter_fetch_upcoming() {
        XCTAssertEqual(presenter.upcomingCount(), 0)
        XCTAssertNil(presenter.getUpcomingMovie(index: 0))
        presenter.fetchMovieUpcomingOutput(result: .success(MovieListTest.loadMovieFromMock(.upcoming)))
        XCTAssertNotEqual(presenter.upcomingCount(), 0)
        XCTAssertNotNil(presenter.getUpcomingMovie(index: 0))
    }
    
    func test_presenter_fetch_search() {
        XCTAssertEqual(presenter.searchedMoviesCount(), 0)
        XCTAssertNil(presenter.getSearchedMovies(index: 0))
        presenter.fetchSearchMovieOutput(result: .success(MovieListTest.loadMovieFromMock(.search)))
        XCTAssertNotEqual(presenter.searchedMoviesCount(), 0)
        XCTAssertNotNil(presenter.getSearchedMovies(index: 0))
    }
    
    func test_interactor_fetches() {
        XCTAssertFalse(interactor.invokeFetchMovieNowPlaying)
        XCTAssertFalse(interactor.invokeFetchMovieUpcoming)
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.invokeFetchMovieNowPlaying)
        XCTAssertTrue(interactor.invokeFetchMovieUpcoming)
    }
}


extension MovieListTest {
    static func loadMovieFromMock<T: Decodable>(_ fileName: MockFileList) -> T {
        let bundle = Bundle(for: VomieTests.self)
        let path = bundle.path(forResource: fileName.rawValue, ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(T.self, from: data)
        return movieResponse
    }
}
