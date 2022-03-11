//
//  GameRequest.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

import Foundation

enum GameError: Error{
    case noDataAvaible
    case canNotProcessData
}

struct GameRequest{
    let resourceURL: URL
    
    init(_ pageId: Int = 1){
        let resourceString = Pin.Links.getGameList + String(pageId)
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error on init")
        }
        self.resourceURL = resourceURL
    }
    
    func getGameList(completion: @escaping(Result<GameList, GameError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            do {
                let gameList = try JSONDecoder().decode(GameList.self, from: jsonData)
                completion(.success(gameList))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
