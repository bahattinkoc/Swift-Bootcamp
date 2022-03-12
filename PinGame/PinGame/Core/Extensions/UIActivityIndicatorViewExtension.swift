//
//  UIActivatorIndicatorViewExtension.swift
//  PinGame
//
//  Created by Bahattin Koç on 12.03.2022.
//

import UIKit

extension UIActivityIndicatorView {
    func getDefaultIndicatorView() -> UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        return loadingIndicator
    }
}
