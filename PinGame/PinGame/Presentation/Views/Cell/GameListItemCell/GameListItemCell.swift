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
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameItem){
        prepareObjects(model: model)
        prepareStars(rate: Int(round(model.rating)))
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func prepareObjects(model: GameItem){
        self.nameLabel.text = model.name
        self.releaseLabel.text = model.released
        self.imageView.image = model.image
        
        circleGameImage()
    }
    
    private func circleGameImage(){
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.systemPurple.cgColor
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.clipsToBounds = true
    }
    
    private func prepareStars(rate: Int){
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
