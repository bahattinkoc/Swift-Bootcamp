//
//  MovieDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import Foundation

//MARK: - PROTOCOLS
protocol MovieDetailPresenterProtocol: AnyObject {
    func viewDidLoad(movie: Movie)
    func similarMoviesCount() -> Int?
    func getSimilarMovie(index: Int) -> Movie?
    func gotoIMDB()
    func didSelectRowAt(index: Int)
    func toggleFavorite()
}

//MARK: - CLASS
final class MovieDetailPresenter {
    unowned var view: MovieDetailViewControllerProtocol?
    let router: MovieDetailRouterProtocol!
    let interactor: MovieDetailInteractorProtocol!
    private var similarMovies: [Movie] = []
    private var favoriteStatus: Bool = false
    private var movieDetail: MovieDetailResponse? {
        didSet {
            guard let poster = movieDetail?.poster_path else { return }
            view?.setMoviePoster(poster)
        }
    }

    init(interactor: MovieDetailInteractorProtocol, router: MovieDetailRouterProtocol, view: MovieDetailViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func fetchSimilarMovies(id: Int) {
        interactor.fetchSimilarMovies(id: id)
    }
    
    private func fetchMovieDetail(id: Int) {
        interactor.fetchMovieDetail(id: id)
    }
    
    private func changeFavoriteStatus(_ status: Bool, _ id: Int) {
        if status {
            FavoriteMovies.instance.IDs.append(id)
        } else {
            if let index = FavoriteMovies.instance.IDs.firstIndex(where: {$0 == id}){
                FavoriteMovies.instance.IDs.remove(at: index)
            }
        }
    }
    
    private func getFavoriteStatus(_ id: Int) -> Bool {
        return FavoriteMovies.instance.IDs.contains(id)
    }
}

//MARK: - EXTENSIONS
extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func toggleFavorite() {
        favoriteStatus.toggle()
        view?.setFavoriteStatus(favoriteStatus)
        changeFavoriteStatus(favoriteStatus, movieDetail?.id ?? 0)
        
    }
    
    func didSelectRowAt(index: Int) {
        router.navigate(.movieDetail(movie: similarMovies.getAt(at: index)))
    }
    
    func gotoIMDB() {
        guard let imdb_id = movieDetail?.imdb_id,
              let url = URL(string: "https://www.imdb.com/title/\(imdb_id)") else { return }
        router.navigate(.openURL(url: url))
    }
    
    func getSimilarMovie(index: Int) -> Movie? {
        similarMovies.getAt(at: index)
    }
    
    func similarMoviesCount() -> Int? {
        similarMovies.count
    }
    
    func viewDidLoad(movie: Movie) {
        view?.setupCollectionView()
        fetchMovieDetail(id: movie.id ?? 0)
        fetchSimilarMovies(id: movie.id ?? 0)
        favoriteStatus = getFavoriteStatus(movie.id ?? 0)
        view?.setFavoriteStatus(favoriteStatus)
        view?.setTitle(movie.original_title ?? "")
        view?.setMovieTitle(movie.original_title ?? "")
        view?.setMovieOverview(movie.overview ?? "")
        view?.setRate(String(movie.vote_average ?? 0))
        view?.setReleaseDate(movie.release_date ?? "")
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func fetchMovieDetailOutput(result: MovieDetailResult) {
        switch result {
            
        case .success(let movieDetailResult):
            movieDetail = movieDetailResult
        case .failure(let error):
            print("*****> fetchMovieDetailOutput error: \(error)")
        }
    }
    
    func fetchSimilarMoviesOutput(result: MovieSourceResult) {
        switch result {
            
        case .success(let similarMoviesResult):
            guard let results = similarMoviesResult.results else { return }
            similarMovies = results
            view?.reloadData()
        case .failure(let error):
            print("*****> fetchSimilarMoviesOutput error: \(error)")
        }
    }
}
