//
//  Comment.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

struct Comment: Decodable {
    public let postId: Int?
    public let id: Int?
    public let name: String?
    public let email: String?
    public let body: String?
}
