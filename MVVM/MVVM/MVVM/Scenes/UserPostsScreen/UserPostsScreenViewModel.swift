//
//  UserPostsScreenViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol UserPostsScreenViewModelProtocol {
    var delegate: UserPostsScreenViewModelDelegate? { get set }
    var postCount: Int { get }
    var allPosts: [Post] { get }
    var getUserId: Int { get }
    func loadPosts()
    func post(index: Int) -> Post?
}

protocol UserPostsScreenViewModelDelegate: AnyObject {
    func reloadData()
}

// MARK: - CLASS
final class UserPostsScreenViewModel {
    weak var delegate: UserPostsScreenViewModelDelegate?
    private let service: NetworkServiceProtocol
    private var posts: [Post] = []
    private let userId: Int
    
    init(service: NetworkServiceProtocol, userId: Int) {
        self.service = service
        self.userId = userId
    }
    
    fileprivate func fetchUsers() {
        service.fetchData(urlString: URLs.postURL.rawValue) { [weak self] (response: Result<[Post], Error>) in
            guard let self = self else { return }
            if case .success(let posts) = response {
                self.posts = posts.filter({ post in
                    post.userId == self.userId
                })
                self.delegate?.reloadData()
            } else if case .failure(let error) = response {
                print("UserPostsScreenViewModel fetchUsers failure. Msg: \(error)")
            }
        }
    }
}

// MARK: - EXTENSIONS
extension UserPostsScreenViewModel: UserPostsScreenViewModelProtocol {
    var getUserId: Int {
        userId
    }
    
    func post(index: Int) -> Post? {
        posts.getAt(at: index)
    }
    
    var postCount: Int {
        posts.count
    }
    
    var allPosts: [Post] {
        posts
    }
    
    func loadPosts() {
        fetchUsers()
    }
}

