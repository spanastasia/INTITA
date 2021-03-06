//
//  UIViewController+AlertView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 04.12.2020.
//

import UIKit

protocol AlertAcceptable {
    func showAlert(header: String, message: String, buttonTitle: String)    
}

extension AlertAcceptable where Self: UIViewController {
    func showAlert(header: String = "error occured".localized, message: String = "comming_soon".localized, buttonTitle: String = "got_it".localized) {
        let alert: AlertView = .fromNib()
        alert.frame = self.view.bounds
        view.addSubview(alert)
        alert.customizeAndShow(header: header, message: message, buttonTitle: buttonTitle)
    }
}

