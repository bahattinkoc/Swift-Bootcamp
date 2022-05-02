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
    func pageControlTapped(index: Int)
    func didSelectRowAt(index: Int, list: Lists)
    func filterSearchMoviesForSearchText(_ searchText: String)
    func searchedMoviesCount() -> Int?
    func getSearchedMovies(index: Int) -> Movie?
    func slideHeaderSlider(status: Bool)
}

enum Lists {
    case nowPlaying
    case upcoming
    case searched
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
        if let searchController = view?.getSearchController {
            return searchController.searchBar.text?.isEmpty ?? true
        }
        return true
    }
    var isFiltering: Bool {
        if let searchController = view?.getSearchController {
            return searchController.isActive && !isSearchBarEmpty
        }
        return false
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
    func slideHeaderSlider(status: Bool) {
        view?.slideHeaderSlider(status: status)
    }
    
    func searchedMoviesCount() -> Int? {
        searchedMovies.count
    }
    
    func getSearchedMovies(index: Int) -> Movie? {
        searchedMovies.getAt(at: index)
    }
    
    func filterSearchMoviesForSearchText(_ searchText: String) {
        if searchText.count > 1 {
            fetchSearchMovie(query: searchText)
        } else {
            view?.searchedTableViewStatus(true)
        }
    }
    
    func didSelectRowAt(index: Int, list: Lists) {
        switch list {
        case .nowPlaying:
            guard let movie = nowPlaying.getAt(at: index) else { return }
            router.navigate(.movieDetail(movie: movie))
        case .upcoming:
            guard let movie = upcoming.getAt(at: index) else { return }
            router.navigate(.movieDetail(movie: movie))
        case .searched:
            guard let movie = searchedMovies.getAt(at: index) else { return }
            router.navigate(.movieDetail(movie: movie))
        }
    }
    
    func pageControlTapped(index: Int) {
        view?.changeSlideWithPageControl(index: index)
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
        view?.setupPageController(count: nowPlayingCount() ?? 5)
        view?.reloadData()
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func fetchSearchMovieOutput(result: MovieSourceResult) {
        switch result {

        case .success(let searchResults):
            guard let results = searchResults.results else {
                view?.searchedTableViewStatus(!isFiltering)
                return
            }
            searchedMovies = results
            view?.searchedTableViewStatus(searchedMovies.isEmpty)
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
