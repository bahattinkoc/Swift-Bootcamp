//
//  MovieDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

//MARK: - PROTOCOLS
protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(id: Int)
    func fetchSimilarMovies(id: Int)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetailOutput(result: MovieDetailResult)
    func fetchSimilarMoviesOutput(result: MovieSourceResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

//MARK: - CLASS
final class MovieDetailInteractor {
    var output: MovieDetailInteractorOutputProtocol?
}

//MARK: - EXTENSIONS
extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    func fetchSimilarMovies(id: Int) {
        movieService.fetchSimilarMovies(id: id) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarMoviesOutput(result: result)
        }
    }
    
    func fetchMovieDetail(id: Int) {
        movieService.fetchMovieDetail(id: id) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetailOutput(result: result)
        }
    }
}
