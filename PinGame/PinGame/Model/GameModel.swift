//
//  Game.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

struct GameList: Decodable {
    let next: String?
    let results: [Results]?
}

struct Results: Decodable {
    let id: Int?
    let name: String?
    let background_image: String?
    let rating: Double?
    let released: String?
    let metacritic: Int?
}

struct GameDetail: Decodable {
    let id: Int?
    let name: String?
    let description: String?
}
