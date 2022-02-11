//
//  MainPageViewController.swift
//  week5Projects
//
//  Created by Bahattin Koç on 10.02.2022.
//

import UIKit

class MainPageViewController: UIViewController {

    
    @IBAction func resetButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isFirst")
        print("Set: \(UserDefaults.standard.bool(forKey: "isFirst"))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(UserDefaults.standard.bool(forKey: "isFirst"))
        if UserDefaults.standard.bool(forKey: "isFirst"){
            print(UserDefaults.standard.bool(forKey: "isFirst"))
            let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardPage") as! ViewController
            page.modalPresentationStyle = .fullScreen
            present(page, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
