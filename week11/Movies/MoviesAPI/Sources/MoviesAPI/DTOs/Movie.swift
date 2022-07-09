//
//  Movie.swift
//  
//
//  Created by Bahattin Koç on 19.03.2022.
//

import Foundation

public struct MovieResult: Decodable {
    public let page: Int?
    public let results: [Movie]?
    public let totalPage, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPage = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Decodable {
    public let id: Int?
    public let title: String?
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
