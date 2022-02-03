//
//  NewsCell.swift
//  week_4
//
//  Created by Bahattin Koç on 29.01.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    
    func configure(model: NewsModel){
        self.newsImageView.image = model.newImg
    }
}
