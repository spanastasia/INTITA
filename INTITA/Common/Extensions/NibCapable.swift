//
//  NibCapable.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 29.12.2020.
//

import UIKit

protocol NibCapable: AnyObject {
    static var identifier: String { get }
    static func nib() -> UINib
}

extension NibCapable {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
