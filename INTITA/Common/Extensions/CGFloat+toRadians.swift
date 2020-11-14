//
//  CGFloat+toRadians.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 14.11.2020.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
