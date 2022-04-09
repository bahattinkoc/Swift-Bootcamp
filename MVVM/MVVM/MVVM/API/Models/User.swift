//
//  User.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

struct User: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let company: Company?
}

struct Company: Decodable {
    let name: String?
}
