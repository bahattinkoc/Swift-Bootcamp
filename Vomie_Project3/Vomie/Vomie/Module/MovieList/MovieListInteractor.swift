//
//  MovieListInteractor.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

//MARK: - PROTOCOLS
protocol MovieListInteractorProtocol: AnyObject {
    func fetchMovieNowPlaying()
    func fetchMovieUpcoming()
    func fetchSearchMovie(query: String)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    func fetchMovieNowPlayingOutput(result: MovieSourceResult)
    func fetchMovieUpcomingOutput(result: MovieSourceResult)
    func fetchSearchMovieOutput(query: String, result: MovieSourceResult)
}

typealias MovieSourceResult = Result<MovieSourceResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

//MARK: - CLASS
final class MovieListInteractor {
    var output: MovieListInteractorOutputProtocol?
}

//MARK: - EXTENSIONS
extension MovieListInteractor: MovieListInteractorProtocol {
    func fetchSearchMovie(query: String) {
        movieService.fetchSearchMovie(query: query) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSearchMovieOutput(query: query, result: result)
        }
    }
    
    func fetchMovieNowPlaying() {
        movieService.fetchMovieNowPlaying { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieNowPlayingOutput(result: result)
        }
    }
    
    func fetchMovieUpcoming() {
        movieService.fetchMovieUpcoming { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieUpcomingOutput(result: result)
        }
    }
}
