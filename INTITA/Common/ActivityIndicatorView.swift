//
//  ActivityIndicatorView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 12.11.2020.
//

import UIKit

class ActivityIndicatorView: UIViewController {
    static var spinner = UIActivityIndicatorView(style: .large)
    static var loadingContainerView = UIView()
    
    class var root: UINavigationController {
        return UIApplication.shared.windows.first!.rootViewController as! UINavigationController
    }
    
    class func startSpinner() {
        DispatchQueue.main.async {
            let vc = ActivityIndicatorView()
            vc.modalPresentationStyle = .overFullScreen
            vc.view.contentMode = .scaleToFill
            
            let blurEffect = UIBlurEffect(style: .regular)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = vc.view.bounds
            loadingContainerView.addSubview(blurredEffectView)
            
            spinner.color = UIColor.primaryColor
            spinner.center = blurredEffectView.center
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            blurredEffectView.contentView.addSubview(spinner)
            
            vc.view.addSubview(loadingContainerView)
            root.present(vc, animated: true, completion: nil)
        }
    }
    
    class func stopSpinner() {
        DispatchQueue.main.async {
            spinner.stopAnimating()
            loadingContainerView.removeFromSuperview()
        }
    }
}


