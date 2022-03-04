//
//  MainStruct.swift
//  week8
//
//  Created by Bahattin Koç on 4.03.2022.
//

import Foundation

struct MainCategories: Decodable{
    let status: Bool?
    let statusCode: Int?
    let data: [Data]?
    let info: Info?
}

struct Data: Decodable{
    let id: Int?
    let name: String?
}

struct Info: Decodable{
    let error: [String]?
    let friendlyMessage: String?
}
