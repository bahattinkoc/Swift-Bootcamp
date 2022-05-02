//
//  MovieDetailTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

import XCTest
@testable import Vomie

final class MovieDetailTest: XCTestCase {
    var presenter: MovieDetailPresenter!
    var view: MovieDetailViewControllerTest!
    var interactor: MovieDetailInteractorTest!
    var router: MovieDetailRouter!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        
        movie = Movie(id: 1, original_language: "Test", original_title: "Test", overview: "Test", poster_path: "Test", release_date: "Test", vote_average: 0, vote_count: 0)
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    func test_view_ui_invokes() {
        XCTAssertFalse(view.invokeSetupCollectionView)
        XCTAssertFalse(view.invokeSetFavoriteStatus)
        XCTAssertFalse(view.invokeSetTitle)
        XCTAssertFalse(view.invokeSetMovieTitle)
        XCTAssertFalse(view.invokeSetMovieOverview)
        XCTAssertFalse(view.invokeSetRate)
        XCTAssertFalse(view.invokeSetReleaseDate)
        presenter.viewDidLoad(movie: movie)
        XCTAssertTrue(view.invokeSetupCollectionView)
        XCTAssertTrue(view.invokeSetFavoriteStatus)
        XCTAssertTrue(view.invokeSetTitle)
        XCTAssertTrue(view.invokeSetMovieTitle)
        XCTAssertTrue(view.invokeSetMovieOverview)
        XCTAssertTrue(view.invokeSetRate)
        XCTAssertTrue(view.invokeSetReleaseDate)
    }
    
    func test_interactor_fetches() {
        XCTAssertFalse(interactor.invokeFetchMovieDetail)
        XCTAssertFalse(interactor.invokeFetchSimilarMovies)
        presenter.viewDidLoad(movie: movie)
        XCTAssertTrue(interactor.invokeFetchMovieDetail)
        XCTAssertTrue(interactor.invokeFetchSimilarMovies)
    }
    
    func test_presenter_fetch_movie_detail() {
        XCTAssertNil(presenter.movieDetail?.imdb_id)
        XCTAssertNil(presenter.movieDetail?.original_title)
        presenter.fetchMovieDetailOutput(result: .success(MovieListTest.loadMovieFromMock(.detailMovie)))
        XCTAssertNotNil(presenter.movieDetail?.imdb_id)
        XCTAssertEqual(presenter.movieDetail?.original_title, "Fantastic Beasts: The Secrets of Dumbledore")
    }
    
    func test_presenter_fetch_similar_movies() {
        XCTAssertEqual(presenter.similarMoviesCount(), 0)
        XCTAssertNil(presenter.getSimilarMovie(index: 0))
        presenter.fetchSimilarMoviesOutput(result: .success(MovieListTest.loadMovieFromMock(.similarMovies)))
        XCTAssertNotEqual(presenter.similarMoviesCount(), 0)
        XCTAssertNotNil(presenter.getSimilarMovie(index: 0))
    }
}


