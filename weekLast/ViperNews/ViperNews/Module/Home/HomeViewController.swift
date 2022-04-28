//
//  HomeViewController.swift
//  ViperNews
//
//  Created by Bahattin Koç on 23.04.2022.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func setupTableView()
}

final class HomeViewController: BaseViewController {

    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func reloadData() {
        
    }
    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func setTitle(_ title: String) {
        
    }
    
    func setupTableView() {
        
    }
}
