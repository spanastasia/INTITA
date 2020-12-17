//
//  UITextField+indent.swift
//  INTITA
//
//  Created by Viacheslav Markov on 28.11.2020.
//

import UIKit

extension UITextField {
    func indent(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX,
                                             y: self.frame.minY,
                                             width: size,
                                             height: self.frame.height))
        self.leftViewMode = .always
    }
}
