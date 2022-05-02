//
//  MovieDetailInteractorTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 2.05.2022.
//

@testable import Vomie

final class MovieDetailInteractorTest: MovieDetailInteractorProtocol {
    var invokeFetchMovieDetail = false
    var invokeFetchSimilarMovies = false
    
    func fetchMovieDetail(id: Int) {
        invokeFetchMovieDetail = true
    }
    
    func fetchSimilarMovies(id: Int) {
        invokeFetchSimilarMovies = true
    }
}
