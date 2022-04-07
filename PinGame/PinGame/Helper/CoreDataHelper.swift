//
//  CoreDataHelper.swift
//  PinGame
//
//  Created by Bahattin Koç on 10.03.2022.
//

import CoreData
import UIKit

final class CoreDataHelper {

    // MARK: - PRIVATE PROPERTIES

    private let appDelegate: AppDelegate?
    private let context: AnyObject?

    // MARK: - INTERNAL STATIC PROPERTIES

    static let instance = CoreDataHelper()

    // MARK: - INTERNAL PROPERTIES

    var currentPagingPageNumber: Int = 1
    var games = [GameItem]()
    var headerGamePages = [GameHeaderVC]()
    var selectedGame: GameItem?

    // MARK: - INIT

    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        
        preparePagingNumber()
    }

    // MARK: - INTERNAL FUNCTIONS

    func getArrayFromDB(entityName: String) -> NSArray? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false // hata dönderirse boşver
        guard let managedContext = context as? NSManagedObjectContext,
              let result = try? managedContext.fetch(request) as NSArray else {
            print("Array was not found!")
            return nil
        }
        return result
    }
    
    func loadGamesFromDB() {
        games.removeAll()
        headerGamePages.removeAll()
        var index = 0
        guard let gamesFromDB = getArrayFromDB(entityName: "GameDB") as? [NSManagedObject] else { return }

        gamesFromDB.forEach { item in
            let gameItem = GameItem(managedItem: item)
            games.append(gameItem)

            if index < CommonConstants.headerCount {
                let headerPage = GameHeaderVC()
                headerPage.configure(managedObject: item)
                headerGamePages.append(headerPage)
                index += 1
            }
        }

        NotificationCenter.default.post(name: NotificationNames.reloadData, object: nil)
    }
    
    func updateLike(id: Int, isLike: Bool){
        guard let gameList = CoreDataHelper.instance.getArrayFromDB(entityName: "GameDB") as? [NSManagedObject],
              let item = gameList.first(where: {$0.value(forKey: "id") as? Int == id}) else { return }
    
        item.setValue(isLike, forKey: "isLike")
        
        // do-catch kullanılmadan guard ile yapılabilir mi?
        ///////////////////
        guard let context = CoreDataHelper.instance.context as? NSManagedObjectContext,
              let _ = try? context.save() else {
            print("Update failed.")
            return
        }
        
//        do {
//            try (CoreDataHelper.instance.context as! NSManagedObjectContext).save()
//        } catch let error as NSError {
//            print(error)
//        }
    }

    func pullGameList(_ page: Int = 1) {
        let getList = GameRequest(page)
        getList.getGameList(completion: { [weak self] result in
            guard let self = self else { return }
            
            if case .failure(let error) = result {
                switch error{
                case .canNotProcessData:
                    print("Can Not Process Data")
                case .noDataAvaible:
                    print("No Data Avaible")
                }
            } else if case .success(let list) = result {
                list.results?.forEach({ game in
                    let index = CoreDataHelper.instance.games.firstIndex { $0.id == game.id }

                    if index == nil,
                       let url = URL(string: game.background_image ?? ""),
                       let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data){
                        self.addNewGame(game: GameItem(result: game, image: image))
                    }
                })

                DispatchQueue.main.async {
                    self.loadGamesFromDB()
                    NotificationCenter.default.post(name: NotificationNames.endLoad, object: nil)
                }
            }
        })
    }

    func pullDetail(_ id: Int = 1) {
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
                guard let gameList = CoreDataHelper.instance.getArrayFromDB(entityName: "GameDB") as? [NSManagedObject],
                      let item = gameList.first(where: { $0.value(forKey: "id") as? Int == id }) else { return }
                
                item.setValue(detail.description, forKey: "descriptionStr")

                do {
                    try (CoreDataHelper.instance.context as! NSManagedObjectContext).save()
                    NotificationCenter.default.post(name: NotificationNames.endLoadDescription, object: nil)
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }

    // MARK: - PRIVATE FUNCTIONS

    private func addNewGame(game: GameItem) {
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
    
    private func preparePagingNumber(){
        if UserDefaults.standard.object(forKey: UserDefaultNames.currentPagingPageNumber) != nil{
            currentPagingPageNumber = UserDefaults.standard.integer(forKey: UserDefaultNames.currentPagingPageNumber)
        } else {
            UserDefaults.standard.setValue(1, forKey: UserDefaultNames.currentPagingPageNumber)
        }
    }
}
