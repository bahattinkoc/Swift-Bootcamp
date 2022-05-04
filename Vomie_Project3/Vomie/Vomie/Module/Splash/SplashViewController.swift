//
//  SplashViewController.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

//MARK: - CLASS
final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidAppear()
    }
}

//MARK: - EXTENSIONS
extension SplashViewController: SplashViewControllerProtocol {
    func noInternetConnection() {
        let alertDialog = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "EXIT", style: .cancel))
        present(alertDialog, animated: true)
    }
}
