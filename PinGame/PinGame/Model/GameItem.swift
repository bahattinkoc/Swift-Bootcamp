//
//  Game.swift
//  PinGame
//
//  Created by Bahattin Koç on 10.03.2022.
//

import UIKit
import CoreData

final class GameItem {
    let id: Int
    let name: String
    var description: String
    let rating: Double
    let released: String
    let image: UIImage
    let metacritic: Int
    var isLike: Bool
    
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

    init(managedItem: NSManagedObject) {
        let image = managedItem.value(forKey: "image") as! Data
        self.id = managedItem.value(forKey: "id") as! Int
        self.name = managedItem.value(forKey: "name") as! String
        self.rating = managedItem.value(forKey: "rating") as! Double
        self.released = managedItem.value(forKey: "released") as! String
        self.image = UIImage(data: image) ?? UIImage(named: "default_image")!
        self.metacritic = managedItem.value(forKey: "metacritic") as! Int
        self.description = managedItem.value(forKey: "descriptionStr") as! String
        self.isLike = managedItem.value(forKey: "isLike") as! Bool
    }
    
    init(result: Results, image: UIImage){
        self.id = result.id ?? 1
        self.name = result.name ?? ""
        self.rating = result.rating ?? 0.0
        self.released = result.released ?? ""
        self.image = image
        self.metacritic = result.metacritic ?? 1
        
        // Defaults
        self.description = ""
        self.isLike = false
    }
}
