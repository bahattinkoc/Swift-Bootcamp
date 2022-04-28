//
//  SplashPresenter.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import Foundation

//MARK: - PROTOCOLS
protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

//MARK: - CLASS
final class SplashPresenter {
    unowned var view: SplashViewControllerProtocol
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!

    init(interactor: SplashInteractorProtocol, router: SplashRouterProtocol, view: SplashViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - EXTENSIONS
extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router.navigate(.movieListScreen)
            }
        } else {
            view.noInternetConnection()
        }
    }
}
