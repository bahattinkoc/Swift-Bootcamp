//
//  ServiceManager.swift
//  ViperNews
//
//  Created by Bahattin Koç on 22.04.2022.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNewsSources(completionHandler: @escaping (NewsSourcesResult) -> ())
    func fetchDetail(sourceId: String, page: Int, query: String?, completionHandler: @escaping (NewsDetailResponse) -> ())
}

struct NewsService: NewsServiceProtocol {
    func fetchNewsSources(completionHandler: @escaping (NewsSourcesResult) -> ()) {
        NetworkManager.shared.request(Router.sources, decodeToType: NewsSourcesResponse.self, completionHandler: completionHandler)
    }
    
    func fetchDetail(sourceId: String, page: Int, query: String?, completionHandler: @escaping (NewsDetailResponse) -> ()) {
        //NetworkManager.shared.request(Router.everything(source: sourceId, page: page, query: query), decodeToType: NewsDetailResponse.self, completionHandler: completionHandler)
    }
}
