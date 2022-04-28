//
//  MovieDetailRouter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: MovieDetailRoutes)
}

enum MovieDetailRoutes {
    case openURL(url: URL)
    case movieDetail(movie: Movie?)
}

//MARK: - CLASS
final class MovieDetailRouter: NSObject {
    private weak var viewController: MovieDetailViewController?

    static func setupModule() -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.viewController = vc
        interactor.output = presenter
        return vc
    }
}

//MARK: - EXTENSIONS
extension MovieDetailRouter: MovieDetailRouterProtocol {
    func navigate(_ route: MovieDetailRoutes) {
        switch route {
        case .openURL(let url):
            UIApplication.shared.open(url)
        case .movieDetail(movie: let movie):
            guard let movie = movie else { return }
            let movieDetailVC = MovieDetailRouter.setupModule()
            movieDetailVC.movie = movie
            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}

