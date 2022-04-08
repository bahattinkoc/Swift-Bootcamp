//
//  UITableView.swift
//  MVVM
//
//  Created by Bahattin Koç on 8.04.2022.
//

import UIKit

extension UITableView {
    func register(cellType: UITableViewCell.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError("UICollectionView Extension dequeCell Fatal Error") }
        return cell
    }
}
