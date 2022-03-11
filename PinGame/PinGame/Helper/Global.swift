//
//  Global.swift
//  PinGame
//
//  Created by Bahattin Koç on 10.03.2022.
//

import Foundation
import CoreData
import UIKit

class Global{
    static let instance = Global()
    var currentPagingPageNumber: Int = 1
    var selectedGame: GameItem?
    private let appDelegate: AppDelegate?
    let context: AnyObject?
    
    var games = [GameItem]()
    var headerGamePages = [GameHeaderVC]()
    
    private init(){
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        context = appDelegate?.persistentContainer.viewContext
    }
    
    func getArrayFromDB(entityName: String) -> NSArray{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false // hata dönderirse boşver
        
        do {
            let result: NSArray = try (context as! NSManagedObjectContext).fetch(request) as NSArray
            return result
        } catch let error as NSError {
            print(error)
            return NSArray()
        }
    }
    
    func loadGamesFromDB(){
        games.removeAll()
        headerGamePages.removeAll()
        var i = 0
        let gamesFromDB = self.getArrayFromDB(entityName: "GameDB") as! [NSManagedObject]
        if gamesFromDB.count > 0{
            for item in gamesFromDB{
                let image = item.value(forKey: "image") as! Data
                self.games.append(GameItem(id: item.value(forKey: "id") as! Int, name: item.value(forKey: "name") as! String, rating: item.value(forKey: "rating") as! Double, released: item.value(forKey: "released") as! String, image: UIImage(data: image) ?? UIImage(named: "default_image")!, metacritic: item.value(forKey: "metacritic") as! Int, description: item.value(forKey: "descriptionStr") as! String, isLike: item.value(forKey: "isLike") as! Bool))
                
                if i <= 2{
                    let headerPage = GameHeaderVC()
                    headerPage.configure(id: item.value(forKey: "id") as! Int, image: UIImage(data: image) ?? UIImage(named: "default_image")!, name: item.value(forKey: "name") as! String)
                    self.headerGamePages.append(headerPage)
                    i += 1
                    print("Header Yüklendi")
                }
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
    }
    
    func addNewGame(game: GameItem){
        let data = NSEntityDescription.insertNewObject(forEntityName: "GameDB", into: context as! NSManagedObjectContext)
        
        data.setValue(game.id, forKey: "id")
        data.setValue(game.name, forKey: "name")
        data.setValue("", forKey: "descriptionStr")
        data.setValue(game.isLike, forKey: "isLike")
        data.setValue(game.rating, forKey: "rating")
        data.setValue(game.released, forKey: "released")
        data.setValue(game.metacritic, forKey: "metacritic")
        data.setValue(game.image.jpegData(compressionQuality: 30), forKey: "image")
        
        do {
            try (self.context as! NSManagedObjectContext).save()
            self.games.append(game)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateLike(id: Int, isLike: Bool){
        let gameList = Global.instance.getArrayFromDB(entityName: "GameDB") as! [NSManagedObject]
        for item in gameList{
            if item.value(forKey: "id") as? Int == id{
                item.setValue(isLike, forKey: "isLike")
                break
            }
        }
        
        do {
            try (Global.instance.context as! NSManagedObjectContext).save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func pullGameList(_ page: Int = 1){
        let getList = GameRequest(page)
        getList.getGameList(completion: { result in
            switch result{
                
            case .failure(let error):
                // Bir custom popup oluşturup göster
                switch error{
                case .canNotProcessData:
                    print("Can Not Process Data")
                case .noDataAvaible:
                    print("No Data Avaible")
                }
                
            case .success(let list):
                // Oyunlar geldi. Globalde var mı kontrol et yoksa ekle.
                for game in list.results!{
                    let index = Global.instance.games.firstIndex { gameItem in return gameItem.id == game.id }
                    
                    if index == nil{
                        if let url = URL(string: game.background_image ?? ""){
                            if let data = try? Data(contentsOf: url) {
                                if let image = UIImage(data: data) {
                                    self.addNewGame(game: GameItem(id: game.id ?? -1, name: game.name ?? "unknown", rating: game.rating ?? 0.0, released: game.released ?? "", image: image, metacritic: game.metacritic ?? -1))
                                    
                                    print("OYUN YOK BAŞTAN İNDİRİLDİ")
                                }
                            }
                        }
                    } else {
                        print("OYUN ZATEN VAR")
                    }
                }
                
                DispatchQueue.main.async {
                    self.loadGamesFromDB()
                    print("Global Games Count: \(self.games.count)")
                    NotificationCenter.default.post(name: Notification.Name("endLoad"), object: nil)
                }
                
            }
        })
    }
    
    func showAll(){
        let gameList = Global.instance.getArrayFromDB(entityName: "GameDB") as! [NSManagedObject]
        for item in gameList{
            print("ITEM: \(item)")
        }
    }
    
    func pullDetail(_ id: Int = 1){
        let getDetail = DetailRequest(id)
        getDetail.getGameDetail { result in
            switch result{
                
            case .failure(let error):
                switch error{
                case .canNotProcessData:
                    print("Can Not Process Data")
                case .noDataAvaible:
                    print("No Data Avaible")
                }
                
            case .success(let detail):
                let gameList = Global.instance.getArrayFromDB(entityName: "GameDB") as! [NSManagedObject]
                for item in gameList{
                    if item.value(forKey: "id") as? Int == id{
                        item.setValue(detail.description?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<br />", with: ""), forKey: "descriptionStr")
                        break
                    }
                }
                
                do {
                    try (Global.instance.context as! NSManagedObjectContext).save()
                    NotificationCenter.default.post(name: Notification.Name("endLoadDescription"), object: nil)
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
