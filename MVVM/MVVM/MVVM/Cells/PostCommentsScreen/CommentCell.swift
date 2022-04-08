//
//  CommentCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 8.04.2022.
//

import UIKit
import SwiftUI

final class CommentCell: UITableViewCell {

    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: Comment) {
        nameLabel.text = model.name
        emailLabel.text = model.email
        commentLabel.text = model.body
    }
}
