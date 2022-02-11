//
//  OnboardViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 11.02.2022.
//

import UIKit

class OnboardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var image: UIImage?
    var titleText: String?
    var detailText: String?
    
    func setup(image: UIImage, titleText: String, detailText: String){
            self.image = image
            self.titleText = titleText
            self.detailText = detailText
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        titleLabel.text = titleText
        detailLabel.text = detailText
    }
}
