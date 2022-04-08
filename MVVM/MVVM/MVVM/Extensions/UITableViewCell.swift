//
//  UITableViewCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 8.04.2022.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
