//
//  WalletCell.swift
//  weekFourProject
//
//  Created by Bahattin Koç on 2.02.2022.
//

import UIKit

class WalletCell: UICollectionViewCell {
    @IBOutlet weak var cellWalletLabel: UILabel!
    
    func configure(model: WalletModel){
        cellWalletLabel.text = model.walletName
    }
    
    @IBAction func silButtonAction(_ sender: Any) {
        for (index, item) in CryptoWalletUIVC.wallets.enumerated(){
            if item.walletName == cellWalletLabel.text!{
                CryptoWalletUIVC.wallets.remove(at: index)
                
                // Sildiğine dair bildirim gönder
                NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
                break
            }
        }
    }
}
