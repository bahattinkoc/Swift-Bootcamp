//
//  UserCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit

final class UserCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(model: User) {
        guard let email = model.email,
              let website = model.website,
              let companyName = model.company?.name else { return }
        nameLabel.text = model.name
        mailLabel.text = "E-Mail: \(email)"
        websiteLabel.text = "Website: \(website)"
        companyNameLabel.text = "Company: \(companyName)"
    }
}
