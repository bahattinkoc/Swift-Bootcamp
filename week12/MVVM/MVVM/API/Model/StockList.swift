//
//  StockList.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation

struct StockList: Decodable {
    let code: String?
    let data: [StockListData]?
}

struct StockListData: Decodable {
    let id: Int?
    let kod: String?
    let ad: String?
}
