//
//  PostDetailsViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol PostDetailsScreenViewModelProtocol {
    var delegate: PostDetailsScreenViewModelDelegate? { get set }
    var getPost: Post { get }
    var commentsCount: Int { get }
    func loadComments()
    func getComments() -> [Comment]
}

protocol PostDetailsScreenViewModelDelegate: AnyObject {
    func changeButtonText()
}

// MARK: - CLASS
final class PostDetailsScreenViewModel {
    weak var delegate: PostDetailsScreenViewModelDelegate?
    private let service: NetworkServiceProtocol
    private let post: Post
    private var comments: [Comment] = []
    
    init(service: NetworkServiceProtocol, post: Post) {
        self.service = service
        self.post = post
    }
    
    fileprivate func fetchComments() {
        service.fetchData(urlString: URLs.commentURL.rawValue) { [weak self] (response: Result<[Comment], Error>) in
            guard let self = self else { return }
            if case .success(let comments) = response {
                self.comments = comments.filter({ comment in
                    comment.postId == self.post.id
                })
                self.delegate?.changeButtonText()
            } else if case .failure(let error) = response {
                print("PostCommentsScreenViewModel fetchComments failure. Msg: \(error)")
            }
        }
    }
}

// MARK: - EXTENSIONS
extension PostDetailsScreenViewModel: PostDetailsScreenViewModelProtocol {
    func getComments() -> [Comment] {
        comments
    }
    
    func loadComments() {
        fetchComments()
    }
    
    var commentsCount: Int {
        comments.count
    }
    
    var getPost: Post {
        post
    }
}
