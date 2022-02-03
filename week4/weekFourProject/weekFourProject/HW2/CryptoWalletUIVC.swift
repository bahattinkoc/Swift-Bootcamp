//
//  CryptoWalletUIVC.swift
//  weekFourProject
//
//  Created by Bahattin Koç on 2.02.2022.
//

import UIKit

class CryptoWalletUIVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // WalletCell'de eleman silerken kullandık
    static var wallets = [WalletModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Bitcoin"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Etherium"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Tether"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Cardano"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Solana"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Ripple"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Dogecoin"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Shiba"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Polkadot"))
        CryptoWalletUIVC.wallets.append(WalletModel(walletName: "Avalanche"))
        
        // Notificationu dinleyeceğimizi bildirdik
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)

        title = "Crypto Wallet"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(action))
    }
    
    // Notification'nın yapacağı fonksiyon (collectionview'ı yenile)
    @objc func loadList(notification: NSNotification) {
      self.collectionView.reloadData()
    }

    // + butonunun yapacağı işler
    @objc func action(sender: UIBarButtonItem){
        // yeni bir alertview tanımla
        let alertView = UIAlertController(title: "Coin Name", message: "Please write your coin name", preferredStyle: .alert)
        // alertview'a textfield ekle
        alertView.addTextField()
        // cancel butonu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // alertview'a ait butonu tanımla ve tıklandığında neler olacağını söyle
        let submitAction = UIAlertAction(title: "Submit", style: .default) {_ in
            let answer = alertView.textFields![0]
            var willAdd = true
            if !String(answer.text!).isEmpty {
                for item in CryptoWalletUIVC.wallets{
                    if item.walletName == answer.text!{
                        let warningAlertView = UIAlertController(title: "Exist", message: "The coin you typed is in the list. Please rewrite.", preferredStyle: .actionSheet)
                        warningAlertView.addAction(UIAlertAction(title: "TAMAM", style: .default))
                        self.present(warningAlertView, animated: true, completion: nil)
                        willAdd = false
                        break
                    }
                }
                if willAdd{
                    CryptoWalletUIVC.wallets.append(WalletModel(walletName: answer.text!))
                    self.collectionView.reloadData()
                }
            }
           }
        // butonu alertview'a koy
        alertView.addAction(submitAction)
        alertView.addAction(cancelAction)
        // alertview'ı sun
        present(alertView, animated: true, completion: nil)
    }
}

extension CryptoWalletUIVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CryptoWalletUIVC.wallets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WalletCell
        cell.cellWalletLabel.text = CryptoWalletUIVC.wallets[indexPath.row].walletName
        return cell
    }
}

// CollectionView'ın cellerinin boyutunu ayarla
extension CryptoWalletUIVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 50)
    }
}
