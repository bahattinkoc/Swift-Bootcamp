//
//  DetailRequest.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import Foundation

struct DetailRequest{
    let resourceURL: URL?
    
    init(_ gameId: Int = 1) {
        let resourceString = Links.getGameDetails + String(gameId) + "?key=" + ApiConstants.apiKey
        resourceURL = URL(string: resourceString)
    }
    
    func getGameDetail(completion: @escaping(Result<GameDetail, GameError>) -> Void) {
        guard let url = resourceURL else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }

            guard let gameDetail = try? JSONDecoder().decode(GameDetail.self, from: jsonData) else {
                completion(.failure(.canNotProcessData))
                return
            }
            completion(.success(gameDetail))
        }
        dataTask.resume()
    }
}
