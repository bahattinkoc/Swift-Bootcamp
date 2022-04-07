//
//  Post.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

struct Post: Decodable {
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String?
}
