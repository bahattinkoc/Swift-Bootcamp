//
//  Links.swift
//  PinGame
//
//  Created by AHMET BEKIR BAKKAL on 11.03.2022.
//

struct Links {
    // Her sayfada 20 oyun geliyor
    // https://api.rawg.io/api/games?page=5&key=aa31ea1948b24564820ff5b050955a60
    static let getGameList = "https://api.rawg.io/api/games?key=" + ApiConstants.apiKey + "&page="
    // https://api.rawg.io/api/games/4248?key=aa31ea1948b24564820ff5b050955a60
    static let getGameDetails = "https://api.rawg.io/api/games/"
}
