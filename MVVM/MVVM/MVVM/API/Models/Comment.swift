//
//  Comment.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
