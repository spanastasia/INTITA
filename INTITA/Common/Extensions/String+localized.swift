//
//  String+localized.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 30.10.2020.
//
import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedCountry(locale: Locale = .current) -> String {
        switch locale.languageCode {
        case "en":
            return "" // from json
        case "ru":
            return "" // from json
        case "ua":
            return "" // from json
        default:
            return self
        }
        
    }
}

