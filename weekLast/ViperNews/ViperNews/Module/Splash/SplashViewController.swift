//
//  SplashViewController.swift
//  ViperNews
//
//  Created by Bahattin Koç on 22.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: BaseViewController {
    
    var presenter: SplashPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidAppear()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func noInternetConnection() {
        showAlert(title: "Error", message: "No internet connection, please check!")
    }
}
