//
//  ForumService.swift
//  MoyaRxSwift
//
//  Created by Bahattin Koç on 9.04.2022.
//

import Moya

enum ForumService {
    case getUsers
    case getUserPosts(userId: Int)
    case getPostComments(postId: Int)
}

extension ForumService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")
    }
    
    var path: String {
        switch self {
            
        case .getUsers:
            return "/users"
        case .getUserPosts(userId: let userId):
            return "/users/\(userId)/posts"
        case .getPostComments(postId: let postId):
            return "/posts/\(postId)/comments"
        }
    }
    
    var method: Method {
        switch self {
        case .getUsers, .getPostComments, .getUserPosts:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
