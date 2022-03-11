//
//  GameListItemCell.swift
//  PinGame
//
//  Created by Bahattin Koç on 10.03.2022.
//

import UIKit

class GameListItemCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameItem){
        
        
        self.nameLabel.text = model.name
        self.ratingLabel.text = model.released
        self.imageView.image = model.image
        let rate = Int(round(model.rating))
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.systemPurple.cgColor
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        
        // Önceki yıldızlar silinmiyordu. Önceki yıldızları siliyoruz
        for view in self.ratingStackView.subviews {
            view.removeFromSuperview()
        }
        
        for i in 1...5{
            let star = UIImageView()
            star.tintColor = .systemPurple
            star.frame.size = CGSize(width: 20, height: 20)
            if i <= rate{
                star.image = UIImage(systemName: "star.fill")
            } else {
                star.image = UIImage(systemName: "star")
            }
            //star.frame.size = CGSize(width: 10, height: 10)
            self.ratingStackView.addArrangedSubview(star)
        }
    }
}
