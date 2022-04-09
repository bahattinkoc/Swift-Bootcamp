//
//  ForumNetworkManager.swift
//  MoyaRxSwift
//
//  Created by Bahattin Koç on 9.04.2022.
//

import RxSwift
import Moya

enum CustomError: Error {
    case unknown
}

struct ForumNetworkManager {
    static let shared = ForumNetworkManager()
    
    private let provider = MoyaProvider<ForumService>()
    
    func getUsers() -> Single[User] {
        return provider.
    }
}
