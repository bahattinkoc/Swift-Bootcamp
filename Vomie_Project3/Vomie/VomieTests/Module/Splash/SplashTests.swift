//
//  SplashTests.swift
//  VomieTests
//
//  Created by Bahattin Koç on 1.05.2022.
//

import XCTest
@testable import Vomie

final class SplashTests: XCTestCase {
    var presenter: SplashPresenter!
    var view: SplashViewControllerTest!
    var interactor: SplashInteractorTest!
    var router: SplashRouter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func test_view_noInternetConnection() {
        XCTAssertFalse(view.invokeNoInternetConnection, "It needs to be false, but now its true!")
        presenter.internetConnection(status: true)
        XCTAssertFalse(view.invokeNoInternetConnection, "It needs to be false, but now its true!")
    }
    
    func test_interactor_checkConnection() {
        XCTAssertFalse(interactor.invokeCheckConnection, "It needs to be false, but now its true!")
        presenter.viewDidAppear()
        XCTAssertTrue(interactor.invokeCheckConnection, "It needs to be true, but now its false!")
    }
}
