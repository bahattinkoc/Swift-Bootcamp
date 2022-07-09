//
//  MovieService.swift
//  
//
//  Created by Bahattin Koç on 19.03.2022.
//

import Foundation
import Alamofire

public protocol MovieServiceProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

public class PopularMoviesService: MovieServiceProtocol {
    public init() {}
    
    public func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=dc5ae13134361c8a261579c7e42a0938&page=1"
        AF.request(urlString).responseData { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(PopularMovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("***** JSON DECODE ERROR *****")
                }
            case .failure(let error):
                print("**** GEÇİCİ SORUN OLUŞTU ****")
            }
        }
    }
}
