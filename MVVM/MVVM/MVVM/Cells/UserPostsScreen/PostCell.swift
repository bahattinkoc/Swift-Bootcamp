//
//  PostCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 8.04.2022.
//

import UIKit

// MARK: - PROTOCOLS
protocol PostCellProtocol {
    var delegate: PostCellDelegate? { get set }
}

protocol PostCellDelegate: AnyObject {
    func showDetail(post: Post)
}

// MARK: - CLASS
class PostCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    private var post: Post?
    weak var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: Post) {
        titleLabel.text = model.title
        post = model
    }

    @IBAction private func showDetailAction(_ sender: UIButton) {
        guard let post = post else { return }
        delegate?.showDetail(post: post)
    }
}
