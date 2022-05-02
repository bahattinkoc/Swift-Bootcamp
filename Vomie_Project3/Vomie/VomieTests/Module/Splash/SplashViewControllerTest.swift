//
//  SplashViewControllerTest.swift
//  VomieTests
//
//  Created by Bahattin Koç on 1.05.2022.
//

@testable import Vomie

final class SplashViewControllerTest: SplashViewControllerProtocol {
    
    var invokeNoInternetConnection = false
    
    func noInternetConnection() {
        invokeNoInternetConnection = true
    }
}
