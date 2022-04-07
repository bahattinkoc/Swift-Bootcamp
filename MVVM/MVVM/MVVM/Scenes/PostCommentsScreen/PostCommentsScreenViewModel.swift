//
//  PostCommentsScreenViewModel.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import NetworkAPI

// MARK: - PROTOCOLS
protocol PostCommentsScreenViewModelProtocol {
    var delegate: PostCommentsScreenViewModelDelegate? { get set }
    var commentCount: Int { get }
    func loadComments()
    func comment(index: Int) -> Comment?
}

protocol PostCommentsScreenViewModelDelegate: AnyObject {
    func reloadData()
}

// MARK: - CLASS
final class PostCommentsScreenViewModel {
    weak var delegate: PostCommentsScreenViewModelDelegate?
    private let service: NetworkServiceProtocol
    private let postId: Int
    private var comments: [Comment] = []
    
    init(service: NetworkServiceProtocol, postId: Int) {
        self.service = service
        self.postId = postId
    }
    
    fileprivate func fetchComments() {
        service.fetchData(urlString: URLs.commentURL.rawValue) { [weak self] (response: Result<[Comment], Error>) in
            guard let self = self else { return }
            if case .success(let comments) = response {
                self.comments = comments.filter({ comment in
                    comment.postId == self.postId
                })
                self.delegate?.reloadData()
            } else if case .failure(let error) = response {
                print("PostCommentsScreenViewModel fetchComments failure. Msg: \(error)")
            }
        }
    }
}

// MARK: - EXTENSIONS
extension PostCommentsScreenViewModel: PostCommentsScreenViewModelProtocol {
    var commentCount: Int {
        comments.count
    }
    
    func loadComments() {
        fetchComments()
    }
    
    func comment(index: Int) -> Comment? {
        comments.getAt(at: index)
    }
}
