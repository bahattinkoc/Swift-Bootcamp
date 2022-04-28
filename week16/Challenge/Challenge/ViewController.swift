//
//  ViewController.swift
//  Challenge
//
//  Created by Bahattin Koç on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleUI()
    }

    private func styleUI() {
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray5.cgColor
        container.layer.cornerRadius = 10
    }
}

