//
//  Post.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

struct Post: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
