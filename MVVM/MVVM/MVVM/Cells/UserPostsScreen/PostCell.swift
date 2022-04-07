//
//  PostCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
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
final class PostCell: UICollectionViewCell {

    weak var delegate: PostCellDelegate?
    @IBOutlet private weak var titleLabel: UILabel!
    private var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction private func showDetailAction(_ sender: UIButton) {
        guard let post = post else { return }
        delegate?.showDetail(post: post)
    }
    
    func configure(model: Post) {
        titleLabel.text = model.title
        post = model
    }
}
