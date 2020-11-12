//
//  ActivityIndicatorView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 12.11.2020.
//

import UIKit

class ActivityIndicatorView: UIViewController {
    
    class func start() {
        
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        //        vc.view.backgroundColor = .cyan
        //        let blurView =
        //        vc.view.addSubview(blurView)
        let blurEffect = UIBlurEffect(style: .regular)
        //Do not add subviews directly to the visual effect view itself, instead add them to the -contentView.'
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        let spinner = UIActivityIndicatorView(style: .large)
        blurredEffectView.addSubview(spinner)
        let root = UIApplication.shared.windows.first!.rootViewController as! UINavigationController
        root.present(vc, animated: true, completion: nil)
    }
}


