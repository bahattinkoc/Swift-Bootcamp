//
//  UserDefaultsViewController.swift
//  week-5
//
//  Created by Bahattin Koç on 5.02.2022.
//

import UIKit
import KeychainAccess

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var infoAgeTextField: UITextField!
    
    let keychain = Keychain(service: "com.bahattinkoc.week5")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //infoLabel.text = "Hi. My name is \(UserDefaults.standard.value(forKey: "username") as? String) and I am \(UserDefaults.standard.value(forKey: "age") as? String) years old "
        
        infoLabel.text = "\(keychain["name"]) yaşım \(keychain["age"])"
    }

    @IBAction func saveButton(_ sender: Any) {
        /*UserDefaults.standard.set(infoTextField.text, forKey: "username")
        UserDefaults.standard.set(infoAgeTextField.text, forKey: "age")
        infoTextField.text = ""
        infoLabel.text = "Kayıt edildi"*/
        
        keychain["name"] = infoTextField.text
        keychain["age"] = infoAgeTextField.text
        infoTextField.text = ""
        infoAgeTextField.text = ""
    }
}
