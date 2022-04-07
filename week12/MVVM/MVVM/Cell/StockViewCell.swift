//
//  StockViewCell.swift
//  MVVM
//
//  Created by Bahattin Koç on 26.03.2022.
//

import UIKit

class StockViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    @IBOutlet weak var stockAveragePrice: UILabel!
    @IBOutlet weak var stockCurrentPrice: UILabel!
    @IBOutlet weak var profitPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.cornerRadius = 5
    }

    func configure(resultsStockModel: ResultStockModel) {
        stockName.text = resultsStockModel.name
        stockCount.text = "\(resultsStockModel.currentCount)"
        stockAveragePrice.text = String(format: "%.2f", resultsStockModel.averagePrice!)
        stockCurrentPrice.text = "\(resultsStockModel.currentPrice)"
        profitPrice.text = String(format: "%.2f", resultsStockModel.profitPrice!)
    }
}
