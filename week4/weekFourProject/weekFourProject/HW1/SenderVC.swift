//
//  SenderVC.swift
//  weekFourProject
//
//  Created by Bahattin Koç on 1.02.2022.
//

import UIKit

protocol MessageDelegate{
    func SendText(text: String)
    func SendImage(img: UIImage)
}

class SenderVC: UIViewController {
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var imageETH: UIImageView!
    @IBOutlet weak var imageAVAX: UIImageView!
    @IBOutlet weak var imageXRP: UIImageView!
    @IBOutlet weak var selectedItemLabel: UILabel!
    
    var msgDelegate: MessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedItemLabel.text = "eth"
        
        let tapEth = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        imageETH.addGestureRecognizer(tapEth)
        imageETH.isUserInteractionEnabled = true
        
        let tapAvax = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        imageAVAX.addGestureRecognizer(tapAvax)
        imageAVAX.isUserInteractionEnabled = true
        
        let tapXrp = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        imageXRP.addGestureRecognizer(tapXrp)
        imageXRP.isUserInteractionEnabled = true
    }
    
    @objc func tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        print("\(tappedImage.restorationIdentifier!)")
        selectedItemLabel.text = tappedImage.restorationIdentifier!
    }
    
    @IBAction func senderBtn(_ sender: Any) {
        guard let msg = msgTextField.text else { return }
        guard let image = UIImage(named: selectedItemLabel.text!) else { return }
        
        
        self.msgDelegate?.SendText(text: msg)
        self.msgDelegate?.SendImage(img: image)
        print("sender: \(msg)")
        
        dismiss(animated: true, completion: nil) // Sayfayı kapattık
    }
    
}
