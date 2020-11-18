//
//  ActivityIndicatorView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 12.11.2020.
//
import UIKit

extension UIViewController {
    func startSpinner() {
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = self.view.bounds
            self.view.addSubview(blurredEffectView)
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.color = UIColor.primaryColor
            spinner.center = blurredEffectView.center
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            blurredEffectView.contentView.addSubview(spinner)
        }
    }
    func stopSpinner() { // also able subviews.last
        DispatchQueue.main.async {
            self.view.subviews.filter { (subview) -> Bool in
                return subview is UIVisualEffectView
            }.forEach { (subview) in
                subview.removeFromSuperview()
            }
        }
    }
}



