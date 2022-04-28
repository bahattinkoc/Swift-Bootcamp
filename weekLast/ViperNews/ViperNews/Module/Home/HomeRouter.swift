//
//  HomeRouter.swift
//  ViperNews
//
//  Created by Bahattin Koç on 23.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(source: Source?)
}

final class HomeRouter {
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
    
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
        
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        //TODO: go to detail
    }
}
