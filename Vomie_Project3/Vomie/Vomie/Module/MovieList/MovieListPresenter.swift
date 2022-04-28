//
//  MovieListPresenter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import SwiftUI

//MARK: - PROTOCOLS
protocol MovieListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func nowPlayingCount() -> Int?
    func getNowPlayingMovie(index: Int) -> Movie?
    func upcomingCount() -> Int?
    func getUpcomingMovie(index: Int) -> Movie?
    func upcomingDidSelectRowAt(index: Int)
    func pageControlTapped(index: Int)
    func didSelectRowAt(index: Int, list: Lists)
    func filterSearchMoviesForSearchText(_ searchText: String)
    func searchedMoviesCount() -> Int
    func getSearchedMovies(index: Int) -> Movie?
}

enum Lists {
    case nowPlaying
    case upcoming
}

//MARK: - CLASS
final class MovieListPresenter {
    unowned var view: MovieListViewControllerProtocol?
    let router: MovieListRouterProtocol!
    let interactor: MovieListInteractorProtocol!
    private var nowPlaying: [Movie] = []
    private var upcoming: [Movie] = []
    private var searchedMovies: [Movie] = []
    var isSearchBarEmpty: Bool {
        view?.getSearchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        view?.getSearchController.isActive ?? false && !isSearchBarEmpty
    }

    init(interactor: MovieListInteractorProtocol, router: MovieListRouterProtocol, view: MovieListViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func fetchMovieNowPlaying() {
        interactor.fetchMovieNowPlaying()
    }
    
    private func fetchMovieUpcoming() {
        interactor.fetchMovieUpcoming()
    }
    
    private func fetchSearchMovie(query: String) {
        interactor.fetchSearchMovie(query: query)
    }
}

//MARK: - EXTENSIONS
extension MovieListPresenter: MovieListPresenterProtocol {
    func searchedMoviesCount() -> Int {
        searchedMovies.count
    }
    
    func getSearchedMovies(index: Int) -> Movie? {
        searchedMovies.getAt(at: index)
    }
    
    func filterSearchMoviesForSearchText(_ searchText: String) {
        fetchSearchMovie(query: searchText)
    }
    
    func didSelectRowAt(index: Int, list: Lists) {
        switch list {
        case .nowPlaying:
            guard let movie = nowPlaying.getAt(at: index) else { return }
            router.navigate(.movieDetail(movie: movie))
        case .upcoming:
            guard let movie = upcoming.getAt(at: index) else { return }
            router.navigate(.movieDetail(movie: movie))
        }
    }
    
    func pageControlTapped(index: Int) {
        view?.changeSlideWithPageControl(index: index)
    }
    
    func upcomingDidSelectRowAt(index: Int) {
        guard let movie = upcoming.getAt(at: index) else { return }
        router.navigate(.movieDetail(movie: movie))
    }
    
    func nowPlayingCount() -> Int? {
        5
    }
    
    func getNowPlayingMovie(index: Int) -> Movie? {
        nowPlaying.getAt(at: index)
    }
    
    func upcomingCount() -> Int? {
        upcoming.count
    }
    
    func getUpcomingMovie(index: Int) -> Movie? {
        upcoming.getAt(at: index)
    }
    
    func viewDidLoad() {
        fetchMovieNowPlaying()
        fetchMovieUpcoming()
        
        view?.setTitle("Movies")
        view?.setupTableView()
        view?.setupCollectionView()
        view?.setupSearchController()
        view?.setupPageController(count: nowPlayingCount() ?? 0)
        view?.reloadData()
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func fetchSearchMovieOutput(query: String, result: MovieSourceResult) {
        switch result {
            
        case .success(let searchResults):
            guard let results = searchResults.results else { return }
            searchedMovies = results
            view?.reloadData()
        case .failure(let error):
            print("*****> fetchSearchMovieOutput error: \(error)")
        }
    }
    
    func fetchMovieNowPlayingOutput(result: MovieSourceResult) {
        switch result {
            
        case .success(let nowPlayingResults):
            guard let results = nowPlayingResults.results else { return }
            nowPlaying = results
            view?.reloadData()
        case .failure(let error):
            print("*****> fetchMovieNowPlayingOutput error: \(error)")
        }
    }
    
    func fetchMovieUpcomingOutput(result: MovieSourceResult) {
        switch result {
            
        case .success(let upcomingResult):
            guard let results = upcomingResult.results else { return }
            upcoming = results
            view?.reloadData()
        case .failure(let error):
            print("*****> fetchMovieUpcomingOutput error: \(error)")
        }
    }
}
