//
//  PostCommentsScreenViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol PostCommentsScreenViewModelProtocol {
    var commentCount: Int { get }
    func comment(index: Int) -> Comment?
}

// MARK: - CLASS
final class PostCommentsScreenViewModel {
    private let service: NetworkServiceProtocol
    private var comments: [Comment] = []
    
    init(service: NetworkServiceProtocol, comments: [Comment]) {
        self.service = service
        self.comments = comments
    }
}

// MARK: - EXTENSIONS
extension PostCommentsScreenViewModel: PostCommentsScreenViewModelProtocol {
    var commentCount: Int {
        comments.count
    }
    
    func comment(index: Int) -> Comment? {
        comments.getAt(at: index)
    }
}
