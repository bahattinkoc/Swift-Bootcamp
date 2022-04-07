//
//  NewStockViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation

/*
 View Controller tarafından erişilmesini istediklerim
 */
protocol NewStockViewModelProtocol {
    var delegate: NewStockViewMdoelDelegate? { get set }
    var numberOfItems: Int? { get }
    
    func getStockList()
    func saveNewStock(newStockModel: inout NewStockModel) // will be refacto
}

/*
 ViewControllera haber vermek istediklerim
 */
protocol NewStockViewMdoelDelegate {
    func updateStockList(stocks: [StockListData])
    func clearFields()
}

final class NewStockViewModel: NewStockViewModelProtocol {
    var delegate: NewStockViewMdoelDelegate?
    var service: StockServiceProtocol = StockService()
    var stocks: [StockListData]?
    
    var numberOfItems: Int? {
        return stocks?.count
    }
    
    func getStockList() {
        service.getStockList { response in
            switch response {
                
            case .success(let result):
                self.stocks = result.data
                self.delegate?.updateStockList(stocks: result.data!) // ViewController a haber veriliyor
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func saveNewStock(newStockModel: inout NewStockModel) {
        let totalPrice = (newStockModel.count ?? 0) * (newStockModel.price ?? 0) + (newStockModel.commission ?? 0)
        newStockModel.totalPrice = totalPrice
        StockRepository().saveStock(newStockModel: newStockModel)
        self.delegate?.clearFields()
    }
}
