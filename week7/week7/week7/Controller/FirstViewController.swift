//
//  TabBarViewController.swift
//  week7
//
//  Created by Bahattin Koç on 19.02.2022.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func tabbarConfig(){
        guard let tabbar = tabBarController?.tabBar else {return}
        tabbar.barTintColor = .red
    }
}
