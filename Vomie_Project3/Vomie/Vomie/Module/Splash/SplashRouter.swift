//
//  SplashRouter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}

//MARK: - ENUMS
enum SplashRoutes {
    case movieListScreen
}

//MARK: - CLASS
final class SplashRouter {
    weak var viewController: SplashViewController?

    static func setupModule() -> SplashViewController {
        let vc = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.output = presenter
        return vc
    }
}

//MARK: - EXTENSIONS
extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .movieListScreen:
            guard let window = viewController?.view.window else { return }
            let movieListVC = MovieListRouter.setupModule()
            let navigationController = UINavigationController(rootViewController: movieListVC)
            window.rootViewController = navigationController
        }
    }
}

