//
//  WelcomeViewController.swift
//  UITestExample
//
//  Created by Bahattin Koç on 9.04.2022.
//

import Foundation
import UIKit

final class WelcomeViewController: UIViewController {
    @IBOutlet private weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.accessibilityIdentifier = "welcomeLabel"
    }
}
