//
//  UserScreenViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit
import NetworkAPI

// MARK: - CLASS
final class UserScreenViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: UserScreenViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: UserCell.self)
        collectionView.setEachRowOneCell()
        viewModel.loadUsers()
    }
}

// MARK: - EXTENSIONS
extension UserScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: UserCell.self, indexPath: indexPath)
        guard let user = viewModel.user(index: indexPath.row) else { return cell }
        cell.configure(model: user)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = createVC(storyboardId: .userPostsScreen) as? UserPostsScreenViewController,
              let userId = self.viewModel.user(index: indexPath.row)?.id else { return }
        let viewModel = UserPostsScreenViewModel(service: NetworkService(), userId: userId)
        viewController.viewModel = viewModel
        pushVC(viewController: viewController)
    }
}

extension UserScreenViewController: UserScreenViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
