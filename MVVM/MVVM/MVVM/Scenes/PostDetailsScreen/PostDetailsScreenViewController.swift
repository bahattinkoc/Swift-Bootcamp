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
    
    var viewModel: PostDetailsScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.getPost.title
        detailLabel.text = viewModel.getPost.body
    }
    
    @IBAction private func showMoreBtnAction(_ sender: UIButton) {
        guard let viewController = createVC(storyboardId: .postCommentsScreen) as? PostCommentsScreenViewController,
              let postId = viewModel.getPost.id else { return }
        let viewModel = PostCommentsScreenViewModel(service: NetworkService(), postId: postId)
        viewController.viewModel = viewModel
        pushVC(viewController: viewController)
    }
}
