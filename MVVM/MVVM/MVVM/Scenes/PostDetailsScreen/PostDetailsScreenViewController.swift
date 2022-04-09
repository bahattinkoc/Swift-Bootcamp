//
//  PostDetailsScreenViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import UIKit
import NetworkAPI

final class PostDetailsScreenViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var readCommentButton: UIButton!
    
    var viewModel: PostDetailsScreenViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.getPost.title
        detailLabel.text = viewModel.getPost.body
        viewModel.loadComments()
    }
    
    @IBAction private func showMoreBtnAction(_ sender: UIButton) {
        guard let viewController = createVC(storyboardId: .postCommentsScreen) as? PostCommentsScreenViewController else { return }
        let viewModel = PostCommentsScreenViewModel(service: NetworkService(), comments: viewModel.getComments())
        viewController.viewModel = viewModel
        pushVC(viewController: viewController)
    }
}

extension PostDetailsScreenViewController: PostDetailsScreenViewModelDelegate {
    func changeButtonText() {
        readCommentButton.setTitle("Read \(viewModel.commentsCount) Comments", for: .normal)
    }
}
