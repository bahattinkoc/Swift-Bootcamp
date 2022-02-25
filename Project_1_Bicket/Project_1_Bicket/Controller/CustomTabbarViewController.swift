//
//  CustomTabbarViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 22.02.2022.
//

import UIKit

class CustomTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 1
        
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.backgroundColor = .systemRed
        self.tabBar.unselectedItemTintColor = .secondaryLabel
        self.tabBar.tintColor = .white
        
        let midButtonBackground = UILabel(frame: CGRect(x: (self.view.bounds.width / 2) - 40, y: -35, width: 80, height: 80))
        midButtonBackground.backgroundColor = .white
        midButtonBackground.layer.shadowColor = UIColor.black.cgColor
        midButtonBackground.layer.shadowOpacity = 0.1
        midButtonBackground.layer.shadowOffset = CGSize(width: 4, height: 4)
        midButtonBackground.layer.cornerRadius = 0.5 * midButtonBackground.bounds.size.width
        midButtonBackground.clipsToBounds = true
        self.tabBar.addSubview(midButtonBackground)
        
        let midButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 35, y: -30, width: 70, height: 70))
        midButton.setBackgroundImage(UIImage(named: "add"), for: .normal)
        midButton.layer.shadowColor = UIColor.black.cgColor
        midButton.layer.shadowOpacity = 0.1
        midButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(midButton)
        self.tabBar.bringSubviewToFront(midButton)
        midButton.addTarget(self, action: #selector(midButtonAction(sender:)), for: .touchUpInside)
        
        // self.view.layoutIfNeeded()
    }
    
    @objc func midButtonAction(sender: UIButton){
        self.selectedIndex = 1
    }
}
