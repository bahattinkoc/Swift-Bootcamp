//
//  MovieListInteractor.swift
//  VomieTests
//
//  Created by Bahattin Koç on 1.05.2022.
//

@testable import Vomie

final class MovieListInteractorTest: MovieListInteractorProtocol {
    var invokeFetchMovieNowPlaying = false
    var invokeFetchMovieUpcoming = false
    var invokeFetchSearchMovie = false
    
    func fetchMovieNowPlaying() {
        invokeFetchMovieNowPlaying = true
    }
    
    func fetchMovieUpcoming() {
        invokeFetchMovieUpcoming = true
    }
    
    func fetchSearchMovie(query: String) {
        invokeFetchSearchMovie = true
    }
}
