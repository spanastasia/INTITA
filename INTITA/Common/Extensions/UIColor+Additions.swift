//
//  UIColor+Additions.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 09.11.2020.
//

import UIKit

extension UIColor {
    class var primaryColor: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 117.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
    }
    class var mediumPriorityColor: UIColor {
        return UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
    }
    class var highPriorityColor: UIColor {
        return UIColor(red: 218/255, green: 77/255, blue: 68/255, alpha: 1.0)
    }
    class var urgentPriorityColor: UIColor {
        return UIColor(red: 120/255, green: 8/255, blue: 35/255, alpha: 1.0)
    }
}
