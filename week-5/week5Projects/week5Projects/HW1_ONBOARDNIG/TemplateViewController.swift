//
//  TemplateViewController.swift
//  week5Projects
//
//  Created by Bahattin Koç on 6.02.2022.
//

import UIKit

class TemplateViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var image: UIImage?
    var titleText: String?
    var detailText: String?
    var backColor: UIColor?
    
    func setup(image: UIImage, titleLabel: String, detailLabel: String, color: UIColor){
        self.image = image
        self.titleText = titleLabel
        self.detailText = detailLabel
        self.backColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        titleLabel.text = titleText
        detailLabel.text = detailText
        view.backgroundColor = backColor
    }
}
