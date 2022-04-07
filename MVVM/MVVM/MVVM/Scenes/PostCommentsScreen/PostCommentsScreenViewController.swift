//
//  PostCommentsScreenViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import UIKit

// MARK: - CLASS
final class PostCommentsScreenViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: PostCommentsScreenViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: CommentCell.self)
        viewModel.loadComments()
    }
}

// MARK: - EXTENSIONS
extension PostCommentsScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.commentCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: CommentCell.self, indexPath: indexPath)
        guard let model = viewModel.comment(index: indexPath.row) else { return cell }
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
}

extension PostCommentsScreenViewController: PostCommentsScreenViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
