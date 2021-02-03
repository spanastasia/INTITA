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
        guard let country = CountryService.countryBy(geocode: self) else {
            return ""
        }
        
        switch locale.languageCode {
        case "en":
            return country.titleEN
        case "ru":
            return country.titleRU
        case "ua":
            return country.titleUA
        default:
            return self
        }
        
    }
}

