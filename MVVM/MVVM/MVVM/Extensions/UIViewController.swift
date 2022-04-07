//
//  UIViewController.swift
//  MVVM
//
//  Created by Bahattin Koç on 6.04.2022.
//

import UIKit
import NetworkAPI

extension UIViewController {
    func pushVC(storyboardId: StoryboardNames) {
        guard let viewController = createVC(storyboardId: storyboardId) else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushVC(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func createVC(storyboardName: String = "Main", storyboardId: StoryboardNames) -> UIViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardId.rawValue)
    }
}
