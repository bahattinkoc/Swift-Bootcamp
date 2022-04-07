//
//  PostDetailsViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol PostDetailsScreenViewModelProtocol {
    var getPost: Post { get }
}

// MARK: - CLASS
final class PostDetailsScreenViewModel {
    private let service: NetworkServiceProtocol
    private let post: Post
    
    init(service: NetworkServiceProtocol, post: Post) {
        self.service = service
        self.post = post
    }
}

// MARK: - EXTENSIONS
extension PostDetailsScreenViewModel: PostDetailsScreenViewModelProtocol {
    var getPost: Post {
        post
    }
}
