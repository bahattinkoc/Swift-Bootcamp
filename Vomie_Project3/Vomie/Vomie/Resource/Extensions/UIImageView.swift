//
//  UIImageView.swift
//  Vomie
//
//  Created by Bahattin Koç on 28.04.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func pullImageFromTheMovieDB(_ urlString: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(urlString)") {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.image = UIImage(systemName: "star")
                }
            }
        }
    }
}
