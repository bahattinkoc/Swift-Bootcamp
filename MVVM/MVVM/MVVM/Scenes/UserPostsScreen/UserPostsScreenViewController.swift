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
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: UserPostsScreenViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: PostCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadPosts()
    }
}

// MARK: - EXTENSIONS
extension UserPostsScreenViewController: UserPostsScreenViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension UserPostsScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.postCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PostCell.self, indexPath: indexPath)
        guard let model = viewModel.post(index: indexPath.row) else { return cell }
        cell.configure(model: model)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 90)
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
