//
//  Shadow+BorderRadius+CornerRadius.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 09.11.2020.
//

import UIKit

extension UIView {
    func bordered () {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primaryColor.cgColor
    }
    func rounded() {
        self.layer.cornerRadius = 10
    }
    func shadowed() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}

