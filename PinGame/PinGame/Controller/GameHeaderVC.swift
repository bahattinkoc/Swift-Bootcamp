//
//  GameHeaderVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

import UIKit

class GameHeaderVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var image: UIImage?
    var id: Int?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.image = image
        nameLabel.text = name
    }
    
    func configure(id: Int,image: UIImage, name: String){
        self.image = image
        self.id = id
        self.name = name
    }
}
