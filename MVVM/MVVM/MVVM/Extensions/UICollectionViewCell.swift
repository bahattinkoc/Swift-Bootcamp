//
//  UICollectionViewCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
