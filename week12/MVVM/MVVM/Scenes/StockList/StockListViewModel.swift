//
//  StockListViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation

protocol StockListViewModelProtocol {
    var delegate: StockListViewModelDelegate? { get set }
    func numberOfItems() -> Int? // var numberOfItems: Int?
    func fetchRecordedStocks() -> [NewStockModel]?
    func fetchRecordedStock(name: String) -> ResultStockModel?
    func fetchStockInfo(stockName: String)
}

protocol StockListViewModelDelegate: AnyObject {
    func updateList(with stock: Chart?)
}

final class StockListViewModel: StockListViewModelProtocol {
    
    private let service: StockServiceProtocol = StockService()
    var delegate: StockListViewModelDelegate?
    var recordedStockCount: Int?
    
    func numberOfItems() -> Int? {
        return recordedStockCount ?? 0
    }
    
    func fetchRecordedStocks() -> [NewStockModel]? {
        let stocks = StockRepository().fetchStocks()
        recordedStockCount = stocks?.count
        return stocks
    }
    
    func fetchRecordedStock(name: String) -> ResultStockModel? {
        var resultStock = ResultStockModel()
        
        return resultStock
    }
    
    func fetchStockInfo(stockName: String) {
        service.fetchStock(stockName: stockName) { response in
            switch response {
            case .success(let data):
                // DELEGATE ile haber ver
                self.delegate?.updateList(with: data.chart)
                break
            case .failure(let error):
                // DELEGATE ile haber ver popup çıkart
                break
            }
        }
    }
}
