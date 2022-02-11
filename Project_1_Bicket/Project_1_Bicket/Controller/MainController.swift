//
//  ViewController.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 10.02.2022.
//

/*
 * Sağ üstte + butonu olacak
 * Ortada bir table view ve search bar olacak
 * TableView'ın cell'eri özel olabilir?
 */

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainController: viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("MainController: viewDidAppear")
        
        if UserDefaults.standard.object(forKey: "PassOnboard") == nil {
            print("In if block")
            let onboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootOnboard")
            onboard.modalPresentationStyle = .fullScreen
            present(onboard, animated: true, completion: nil)
        }
    }
}

