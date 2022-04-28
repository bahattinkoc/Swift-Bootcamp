//
//  SplashInteractor.swift
//  CIViperGenerator
//
//  Created by Bahattin on 26.04.2022.
//  Copyright © 2022 Bahattin. All rights reserved.
//

import MovieNetwork

//MARK: - PROTOCOLS
protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

//MARK: - CLASS
final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

//MARK: - EXTENSIONS
extension SplashInteractor: SplashInteractorProtocol {
    func checkInternetConnection() {
        let internetStatus = MovieNetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
}
