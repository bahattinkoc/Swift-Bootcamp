///Users/bahattinkoc/Desktop/IOS/Homeworks/MVVM/MVVM/MVVM/SceneDelegate.swift
//  SceneDelegate.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit
import NetworkAPI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow(windowScene: UIWindowScene(session: session, connectionOptions: connectionOptions))
        guard let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardNames.userScreen.rawValue) as? UserScreenViewController else { return }
        let viewModel = UserScreenViewModel(service: NetworkService())
        rootVC.viewModel = viewModel
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

