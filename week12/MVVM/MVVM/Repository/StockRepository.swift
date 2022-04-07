//
//  StockRepository.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation
import CoreData
import UIKit

protocol StockRepositoryProtocol {
    func saveStock(newStockModel: NewStockModel)
    func fetchStocks() -> [NewStockModel]?
}

class StockRepository: StockRepositoryProtocol {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var stocks = [NewStockModel]()
    
    func saveStock(newStockModel: NewStockModel) {
        let viewContext = appDelegate.persistentContainer.viewContext
        
        if viewContext.hasChanges {
            try! viewContext.save()
        }
        
        let newStock = NSEntityDescription.insertNewObject(forEntityName: "NewStockEntity", into: viewContext)
        
        newStock.setValue(newStockModel.date, forKey: "date")
        newStock.setValue(newStockModel.name, forKey: "name")
        newStock.setValue(newStockModel.count, forKey: "count")
        newStock.setValue(newStockModel.price, forKey: "price")
        newStock.setValue(newStockModel.commission, forKey: "commission")
        newStock.setValue(newStockModel.totalPrice, forKey: "totalPrice")
        
        do {
            try viewContext.save()
            NSLog("*** BAŞARIYLA KAYDEDİLDİ ***", newStock)
        } catch {
            print("*** KAYDEDİLEMEDİ ***")
        }
    }
    
    func fetchStocks() -> [NewStockModel]? {
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NewStockEntity")
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    guard let date = result.value(forKey: "date") as? String else { return nil }
                    guard let name = result.value(forKey: "name") as? String else { return nil }
                    guard let count = result.value(forKey: "count") as? Double else { return nil }
                    guard let price = result.value(forKey: "price") as? Double else { return nil }
                    guard let commission = result.value(forKey: "commission") as? Double else { return nil }
                    guard let totalPrice = result.value(forKey: "totalPrice") as? Double else { return nil }
                    
                    let stock = NewStockModel(date: date, name: name, count: count, price: price, commission: commission, totalPrice: totalPrice)
                    
                    stocks.append(stock)
                }
            }
        } catch {
            print("HATA")
        }
            
        return stocks
    }
}
