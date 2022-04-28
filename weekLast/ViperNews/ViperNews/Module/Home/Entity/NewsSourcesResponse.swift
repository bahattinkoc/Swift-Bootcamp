//
//  NewsSourcesResponse.swift
//  ViperNews
//
//  Created by Bahattin Koç on 22.04.2022.
//

//MARK: - NewsSourcesResponse
struct NewsSourcesResponse: Codable {
    let status: String?
    let source: [Source]?
}

//MARK: - Source
struct Source: Codable {
    let id, name, description, url, language, country: String?
    let category: Category?
}

//MARK: - Category
enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}
