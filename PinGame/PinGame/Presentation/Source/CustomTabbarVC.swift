//
//  CustomTabbarVC.swift
//  PinGame
//
//  Created by Bahattin Koç on 11.03.2022.
//

import UIKit

final class CustomTabbarVC: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        selectedIndex = 0
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundColor = .systemPurple
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.tintColor = .white
    }
}
