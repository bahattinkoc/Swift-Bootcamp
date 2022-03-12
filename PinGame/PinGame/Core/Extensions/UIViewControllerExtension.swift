//
//  UIViewControllerExtension.swift
//  PinGame
//
//  Created by AHMET BEKIR BAKKAL on 11.03.2022.
//

import UIKit

extension UIViewController {

    func pushVC(storyboardName: String, storyboardId: StoryboardNames) {
        let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardId.rawValue)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func presentVC(storyboardName: String, storyboardId: StoryboardNames, style: UIModalPresentationStyle = .fullScreen) {
        let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardId.rawValue)
        viewController.modalPresentationStyle = style
        present(viewController, animated: true, completion: nil)
    }
}
