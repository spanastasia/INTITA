//
//  Shadow+BorderRadius+CornerRadius.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 09.11.2020.
//

import UIKit

extension UIView {
    func bordered(borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.primaryColor.cgColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    func rounded(cornerRadius: CGFloat = 10) {
        self.layer.cornerRadius = cornerRadius
    }
    func shadowed(
        shadowColor: CGColor = UIColor.black.cgColor,
        shadowOffset: CGSize = CGSize(width: 0, height: 4),
        shadowRadius: CGFloat = 4.0, shadowOpacity: Float = 0.25
    )
    {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
}

