//
//  UIView+fromNib.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 10.11.2020.
//

import UIKit

extension UIView {
    func fromNib() -> Self {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self
        else {
            return Self()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
