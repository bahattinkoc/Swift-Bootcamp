//
//  UserCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit
import NetworkAPI

final class UserCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(model: User) {
        nameLabel.text = model.name
        mailLabel.text = model.email
        websiteLabel.text = model.website
    }
}
