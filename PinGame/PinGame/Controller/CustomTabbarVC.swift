//
//  CustomTabbarVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

class CustomTabbarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 0
        
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.backgroundColor = .systemPurple
        self.tabBar.unselectedItemTintColor = .secondaryLabel
        self.tabBar.tintColor = .white
    }
}
