//
//  DetailRequest.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import Foundation

struct DetailRequest{
    let resourceURL: URL
    
    init(_ gameId: Int = 1){
        let resourceString = Pin.Links.getGameDetails + String(gameId) + "?key=" + Pin.User.apiKey
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error on init")
        }
        self.resourceURL = resourceURL
    }
    
    func getGameDetail(completion: @escaping(Result<GameDetail, GameError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvaible))
                return
            }
            
            do {
                let gameDetail = try JSONDecoder().decode(GameDetail.self, from: jsonData)
                completion(.success(gameDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
