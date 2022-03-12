//
//  GameHeaderVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 9.03.2022.
//

import UIKit
import CoreData

class GameHeaderVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    // MARK: - PROPERTIES
    
    var image: UIImage?
    var id: Int?
    var name: String?
    
    // MARK: - EXTERNAL FUNTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.image = image
        nameLabel.text = name
    }
    
    // MARK: - PUBLIC FUNTIONS
    
    func configure(id: Int,image: UIImage, name: String){
        self.image = image
        self.id = id
        self.name = name
    }

    func configure(managedObject: NSManagedObject){
        if let image = managedObject.value(forKey: "image") as? Data,
           let id = managedObject.value(forKey: "id") as? Int,
           let name = managedObject.value(forKey: "name") as? String {
            self.id = id
            self.image = UIImage(data: image)
            self.name = name
        }
    }
}
