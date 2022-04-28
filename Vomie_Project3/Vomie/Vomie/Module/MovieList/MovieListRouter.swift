//
//  MovieListRouter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

//MARK: - PROTOCOLS
protocol MovieListRouterProtocol: AnyObject {
    func navigate(_ route: MovieListRoutes)
}

enum MovieListRoutes {
    case movieDetail(movie: Movie?)
}

//MARK: - CLASS
final class MovieListRouter {
    private weak var viewController: MovieListViewController?

    static func setupModule() -> MovieListViewController {
        let vc = MovieListViewController()
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

//MARK: - EXTENSIONS
extension MovieListRouter: MovieListRouterProtocol {
    func navigate(_ route: MovieListRoutes) {
        switch route {
        case .movieDetail(let movie):
            guard let movie = movie else { return }
            let movieDetailVC = MovieDetailRouter.setupModule()
            movieDetailVC.movie = movie
            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}

