//
//  UserPostsScreenViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit
import NetworkAPI

// MARK: - CLASS
final class UserPostsScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: UserPostsScreenViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: PostCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadPosts()
    }
}

// MARK: - EXTENSIONS
extension UserPostsScreenViewController: UserPostsScreenViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension UserPostsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: PostCell.self, indexPath: indexPath)
        guard let model = viewModel.post(index: indexPath.row) else { return cell }
        cell.configure(model: model)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemBackground : .systemGray5
        cell.delegate = self
        return cell
    }
}

extension UserPostsScreenViewController: PostCellDelegate {
    func showDetail(post: Post) {
        guard let viewController = createVC(storyboardId: .postDetailsScreen) as? PostDetailsScreenViewController else { return }
        let viewModel = PostDetailsScreenViewModel(service: NetworkService(), post: post)
        viewController.viewModel = viewModel
        pushVC(viewController: viewController)
    }
}
