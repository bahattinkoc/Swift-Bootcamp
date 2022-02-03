//
//  ShowerVC.swift
//  weekFourProject
//
//  Created by Bahattin Koç on 1.02.2022.
//

import UIKit

class ShowerVC: UIViewController {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imagePanel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getBtn(_ sender: UIButton) {
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SenderVC") as! SenderVC
        senderVC.msgDelegate = self // self diyerek delegate'i burada kullanacağımızı söyledik
        present(senderVC, animated: true, completion: nil) // Diğer sayfayı açtık
    }
}

// Delegatemizi classımıza extension ettik
extension ShowerVC: MessageDelegate {
    func SendText(text: String) {
        msgLabel.text = text
        print(text)
    }
    
    func SendImage(img: UIImage) {
        imagePanel.image = img
    }
}
