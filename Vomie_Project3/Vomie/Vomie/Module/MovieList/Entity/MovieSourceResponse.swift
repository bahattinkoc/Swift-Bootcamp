//
//  MovieSourceResponse.swift
//  Vomie
//
//  Created by Bahattin Koç on 25.04.2022.
//

//MARK: - MovieSourceResponse
struct MovieSourceResponse: Decodable {
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
    let results: [Movie]?
}

//MARK: - Movie
struct Movie: Decodable {
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
