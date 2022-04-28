//
//  HomeInteractor.swift
//  ViperNews
//
//  Created by Bahattin Koç on 23.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchNewsSources()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchNewsSourcesOutput(result: NewsSourcesResult)
}

typealias NewsSourcesResult = Result<NewsSourcesResponse, Error>
fileprivate var newsService: NewsServiceProtocol = NewsService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchNewsSources() {
        //TODO: yapılacak
    }
}
