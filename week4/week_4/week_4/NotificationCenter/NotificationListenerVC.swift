//
//  NotificationListenerVC.swift
//  week_4
//
//  Created by Bahattin Koç on 29.01.2022.
//

import UIKit

class NotificationListenerVC: UIViewController {

    @IBOutlet weak var notificationImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let notificationCenter: NotificationCenter = .default
        notificationCenter.addObserver(self, selector: #selector(changeImage), name: .sendDataNoification, object: nil)
    }

    @objc func changeImage(){
        self.notificationImage.image = UIImage(named: "turkcell1")
    }
}
