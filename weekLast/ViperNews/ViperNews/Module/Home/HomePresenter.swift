//
//  HomePresenter.swift
//  ViperNews
//
//  Created by Bahattin Koç on 23.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func source(index: Int) -> Source?
    func didSelectRowAt(index: Int)
}

final class HomePresenter: HomePresenterProtocol {
    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var sources: [Source] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        
    }
    
    func numberOfItems() -> Int {
        0
    }
    
    func source(index: Int) -> Source? {
        
    }
    
    func didSelectRowAt(index: Int) {
        
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchNewsSourcesOutput(result: NewsSourcesResult) {
        
    }
}
