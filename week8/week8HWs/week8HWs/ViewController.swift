//
//  ViewController.swift
//  week8HWs
//
//  Created by Bahattin Koç on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        redView.clipsToBounds = true
        redView.layer.masksToBounds = true
        redView.layer.shadowOpacity = 1
        
        redView.layer.cornerRadius = 20
        
    }


}

