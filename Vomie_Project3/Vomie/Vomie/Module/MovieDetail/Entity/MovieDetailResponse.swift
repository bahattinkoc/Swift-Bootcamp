//
//  MovieDetailResponse.swift
//  Vomie
//
//  Created by Bahattin Koç on 25.04.2022.
//

//MARK: - MovieDetailResponse
struct MovieDetailResponse: Decodable {
    let id: Int?
    let homepage: String?
    let imdb_id: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let status: String?
    let vote_average: Double?
    let vote_count: Int?
}
