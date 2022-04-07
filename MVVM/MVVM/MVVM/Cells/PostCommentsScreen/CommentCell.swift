//
//  CommentCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 7.04.2022.
//

import UIKit

final class CommentCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: Comment) {
        nameLabel.text = model.name
        emailLabel.text = model.email
        commentTextField.text = model.body
    }
}
