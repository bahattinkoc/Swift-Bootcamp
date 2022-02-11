//
//  User.swift
//  week-5
//
//  Created by Bahattin Koç on 4.02.2022.
//

import Foundation

struct User: Decodable{
    let username: String // jsondaki ile aynı isimde olması gerekiyor
    let email: String
    let company: Company
}

struct Company: Decodable{
    let name: String?
}
