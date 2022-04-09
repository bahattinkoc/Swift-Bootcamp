//
//  PostCommentsScreenViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import UIKit

// MARK: - CLASS
final class PostCommentsScreenViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: PostCommentsScreenViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: CommentCell.self)
    }
}

// MARK: - EXTENSIONS
extension PostCommentsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.commentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: CommentCell.self, indexPath: indexPath)
        guard let model = viewModel.comment(index: indexPath.row) else { return cell }
        cell.configure(model: model)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemBackground : .systemGray5
        return cell
    }
}
