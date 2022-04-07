//
//  CoinCell.swift
//  iCryptoin
//
//  Created by Bahattin Koç on 17.03.2022.
//

import UIKit

final class CoinCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var shortName: UILabel!
    @IBOutlet private weak var longName: UILabel!
    @IBOutlet private weak var currentPrice: UILabel!
    @IBOutlet private weak var volume24h: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(model: CoinItem) {
        shortName.text = model.symbol
        longName.text = model.name
        currentPrice.text = model.price
        volume24h.text = "\(model.change)% ($\(findDifferentVolume(model: model))"
        imageView.image = model.icon
    }
    
    private func findDifferentVolume(model: CoinItem) -> Double {
        return (Double(model.price ?? "0") ?? 1) * (Double(model.change ?? "0") ?? 1)
    }
}
