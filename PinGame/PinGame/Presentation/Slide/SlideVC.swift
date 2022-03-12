//
//  SlideVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 6.03.2022.
//

import UIKit

class SlideVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - PROPERTIES
    
    var slide: Slide?
    
    // MARK: - EXTERNAL FUNCTONS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: slide?.imageTxt ?? "")
        titleLabel.text = slide?.title ?? ""
        detailLabel.text = slide?.detail ?? ""
    }
    
    // MARK: - FUNCTIONS
    
    func configure(slide: Slide){
        self.slide = slide
    }
}
