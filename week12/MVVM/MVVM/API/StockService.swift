//
//  StockService.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation
import Alamofire

protocol StockServiceProtocol {
    func getStockList(completion: @escaping (Result<StockList, Error>) -> Void)
    func fetchStock(stockName: String?, completion: @escaping(Result<StockResponse, Error>) -> Void)
}

class StockService: StockServiceProtocol {
    public init() { }
    
    func getStockList(completion: @escaping (Result<StockList, Error>) -> Void) {
        let urlString = "https://bigpara.hurriyet.com.tr/api/v1/hisse/list"
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let stockList = try decoder.decode(StockList.self, from: data)
                    completion(.success(stockList))
                } catch {
                    print("**** JSON DECODE ERROR ****")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchStock(stockName: String?, completion: @escaping (Result<StockResponse, Error>) -> Void) {
        let urlString = "https://query1.finance.yahoo.com/v8/finance/chart/\(stockName ?? "").IS?region=US&lang=en-US&includePrePost=false&interval=2m&useYfid=true&range=1d&corsDomain=finance.yahoo.com&.tsrc=finance"
        
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let response = try decoder.decode(StockResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("**** JSON DECODE ERROR ****")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
