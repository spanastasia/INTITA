//
//  NibCapable.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 29.12.2020.
//

import UIKit

protocol NibCapable: AnyObject {
    static var identifire: String { get }
    static func nib() -> UINib
}

extension NibCapable {
    static var identifire: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
}
