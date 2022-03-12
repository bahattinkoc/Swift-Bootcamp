//
//  GameRequest.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

import Foundation

enum GameError: Error {
    case noDataAvaible
    case canNotProcessData
}

struct GameRequest {
    private let resourceURL: URL?
    
    init(_ pageId: Int = 1) {
        let resourceString = Links.getGameList + String(pageId)
        resourceURL = URL(string: resourceString)
    }
    
    func getGameList(completion: @escaping(Result<GameList, GameError>) -> Void) {
        guard let url = resourceURL else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }

            guard let gameList = try? JSONDecoder().decode(GameList.self, from: jsonData) else {
                completion(.failure(.canNotProcessData))
                return
            }
            completion(.success(gameList))
        }
        dataTask.resume()
    }
}
