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
        let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
        self.window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(withIdentifier: StoryboardNames.userScreen.rawValue) as? UserScreenViewController else { return }
        let viewModel = UserScreenViewModel(service: NetworkService())
        rootVC.viewModel = viewModel
        let navigation = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
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

