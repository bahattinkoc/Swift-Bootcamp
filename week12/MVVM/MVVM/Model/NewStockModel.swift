//
//  NewStockModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import Foundation

struct NewStockModel: Decodable {
    var date: String?
    var name: String?
    var count: Double?
    var price: Double?
    var commission: Double?
    var totalPrice: Double?
}
