//
//  Game.swift
//  PinGame
//
//  Created by Bahattin Koç on 10.03.2022.
//

import Foundation
import UIKit

class GameItem{
    let id: Int
    let name: String
    var description: String = ""
    let rating: Double
    let released: String
    let image: UIImage
    let metacritic: Int
    var isLike: Bool = false
    
    init(id: Int, name: String, rating: Double, released: String, image: UIImage, metacritic: Int, description: String = "", isLike: Bool = false){
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.image = image
        self.metacritic = metacritic
        self.description = description
        self.isLike = isLike
    }
    
    func setDescription(description: String){
        self.description = description
    }
}
