//
//  ActivityIndicatorView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 12.11.2020.
//
import UIKit

protocol ActivityIndicatorViewProtocol: class {
    static func startSpinner()
    static func stopSpinner()
}


class ActivityIndicatorView: UIViewController, ActivityIndicatorViewProtocol {
    private static var spinner = UIActivityIndicatorView(style: .large)
    private static var loadingContainerView: UIView?
    
    class private var root: UINavigationController {
        return UIApplication.shared.windows.first!.rootViewController as! UINavigationController
    }
    
    class func startSpinner() {
        DispatchQueue.main.async {
            loadingContainerView = UIView()
            let vc = ActivityIndicatorView()
            vc.modalPresentationStyle = .overFullScreen
            vc.view.contentMode = .scaleToFill
            
            let blurEffect = UIBlurEffect(style: .regular)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = vc.view.bounds
            vc.view.addSubview(blurredEffectView)
//            loadingContainerView?.addSubview(blurredEffectView)
            
            spinner.color = UIColor.primaryColor
            spinner.center = blurredEffectView.center
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            blurredEffectView.contentView.addSubview(spinner)
            
//            vc.view.addSubview(loadingContainerView!)
            root.present(vc, animated: true, completion: nil)
            
        }
    }
    
    class func stopSpinner() {
        DispatchQueue.main.async {
            spinner.stopAnimating()
//            loadingContainerView?.removeFromSuperview()
//            root.popViewController(animated: true)
            
            if let currentVC = root.presentedViewController as? ActivityIndicatorView {
                    spinner.stopAnimating()
                    currentVC.dismiss(animated: true, completion: nil)
                }
        }
    }
}


