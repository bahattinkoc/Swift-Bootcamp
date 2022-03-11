//
//  Constant.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

import Foundation

struct Pin{
    struct Links{
        // Her sayfada 20 oyun geliyor
        // https://api.rawg.io/api/games?page=5&key=aa31ea1948b24564820ff5b050955a60
        static let getGameList = "https://api.rawg.io/api/games?key=" + User.apiKey + "&page="
        // https://api.rawg.io/api/games/4248?key=aa31ea1948b24564820ff5b050955a60
        static let getGameDetails = "https://api.rawg.io/api/games/"
    }
    
    struct User{
        static let apiKey = "aa31ea1948b24564820ff5b050955a60"
    }
    
    struct StoryboardID{
        static let onboardingVC = "OnboardingViewController"
        static let searchListVC = "SearchListVC"
        static let detailPageVC = "DetailPageVC"
        static let tabbarVC = "TabbarVC"
        static let favoritesVC = "FavoritesVC"
    }
}
