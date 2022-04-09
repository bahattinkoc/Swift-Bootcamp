//
//  ViewController.swift
//  UITestExample
//
//  Created by Bahattin Koç on 9.04.2022.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifiers()
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        
    }
    
}

extension ViewController {
    func setAccessibilityIdentifiers() {
        userNameTextField.accessibilityIdentifier = "userNameTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        doneButton.accessibilityIdentifier = "doneButton"
    }
}
