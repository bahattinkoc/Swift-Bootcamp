//
//  UICollectionView.swift
//  Movies
//
//  Created by Bahattin Koç on 19.03.2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Register fatar error. (func: dequeCell)")
        }
        return cell
    }
}
