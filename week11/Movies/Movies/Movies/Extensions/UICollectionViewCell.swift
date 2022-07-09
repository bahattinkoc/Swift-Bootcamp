//
//  UICollectionViewCell.swift
//  Movies
//
//  Created by Bahattin Koç on 19.03.2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
