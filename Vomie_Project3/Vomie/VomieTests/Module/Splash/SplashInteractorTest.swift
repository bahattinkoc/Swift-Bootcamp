//
//  MockInteractor.swift
//  VomieTests
//
//  Created by Bahattin Koç on 1.05.2022.
//

@testable import Vomie

final class SplashInteractorTest: SplashInteractorProtocol {
    
    var invokeCheckConnection = false
    
    func checkInternetConnection() {
        invokeCheckConnection = true
    }
}
