//
//  NotificationSenderVC.swift
//  week_4
//
//  Created by Bahattin Koç on 29.01.2022.
//

import UIKit

class NotificationSenderVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sendNotificationBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .sendDataNoification, object: nil, userInfo: nil)
        dismiss(animated: true, completion: nil)
        
        // HW: Resim Dışında diğer ekrana bir veri göndererek ilk ekrandaki label a yazdırın
        // HW: GÖnderilecek data kullanıcıdan alınmalıdır
        // HW: frame vs bound farkı nedir. açıklayınız?
        // HW: static keyword neden kullanırız. Örnek bir kullanım yaparak açıklayınız
        // HW: Euler 8,9,10,11 ödev
        // HW: Bir tableview / collectionView kullanarak listeye eleman ekleyebileceğimiz bir uygulama yapınız (sağ üst + butonu?, popup açılacak bir textbox ve tamam butonu-tamama basınca listeye ekleyecek) (sağ üste konacak bir + butonu ile açılacak alertview içindeki texfield il alınan veriyi tableview/collectionView a  ekleyiniz) (storage)
    }
}
