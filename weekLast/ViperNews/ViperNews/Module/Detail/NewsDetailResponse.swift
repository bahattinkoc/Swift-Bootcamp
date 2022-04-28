//
//  NewsDetailResponse.swift
//  ViperNews
//
//  Created by Bahattin Koç on 22.04.2022.
//

import Foundation

//MARK: - NewsDetailResponse
struct NewsDetailResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

//MARK: - Article
struct Article: Codable {
    let source: ArticleSource?
    let author, title, description, url, urlToImage, pusblishedAt, content: String?
    var readingListStatus: Bool = false
}

//MARK: - ArticleSource
struct ArticleSource: Codable {
    let id: String?
    let name: String?
}
