//
//  CoinItem.swift
//  iCryptoin
//
//  Created by Bahattin Koç on 18.03.2022.
//

import UIKit

final class CoinItem {
    var symbol: String
    var name: String
    var icon: UIImage
    var price: String
    var listedAt: Int
    var change: String
    var rank: Int
    
    init(model: Coin) {
        self.symbol = model.symbol ?? ""
        self.name = model.name ?? ""
        self.price = String(Double(model.price ?? "")?.rounded(count: 3) ?? 0)
        self.listedAt = model.listedAt ?? 1
        self.change = model.change ?? ""
        self.rank = model.rank ?? 1
        self.icon = UIImage()
        self.downloadImage(link: model.iconUrl ?? "")
    }
    
    private func downloadImage(link: String) {
        var restoreLink = link.replacingOccurrences(of: ".svg", with: ".png")
        if let url = URL(string: restoreLink),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data)?.jpegData(compressionQuality: 30){
            icon = UIImage(data: image) ?? UIImage()
        }
    }
}

extension Double {
    func rounded(count: Int) -> Double{
        let multiply = pow(10.0, Double(count))
        return (self * multiply).rounded() / multiply
    }
}
