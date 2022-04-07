//
//  CoinRequest.swift
//  iCryptoin
//
//  Created by Bahattin Koç on 16.03.2022.
//

import Foundation

enum CoinError: Error {
    case noDataAvaible
    case canNotProcessData
}

struct CoinRequest {
    private let resourceURL: URL?
    
    init(_ pageId: Int = 1) {
        let resourceString = Links.coinResourceURL
        resourceURL = URL(string: resourceString)
    }
    
    func getGameList(completion: @escaping(Result<CoinModel, CoinError>) -> Void) {
        guard let url = resourceURL else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }

            guard let coinList = try? JSONDecoder().decode(CoinModel.self, from: jsonData) else {
                completion(.failure(.canNotProcessData))
                return
            }
            completion(.success(coinList))
        }
        dataTask.resume()
    }
}
