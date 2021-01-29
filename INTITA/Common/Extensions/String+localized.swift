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
        let countries = CountryService().getCountries()
        let country = countries?.filter {
            $0.geocode == self
        }
        
        switch locale.languageCode {
        case "en":
            return country?.first?.titleEN ?? "" // from json
        case "ru":
            return country?.first?.titleRU ?? "" // from json
        case "ua":
            return country?.first?.titleUA ?? "" // from json
        default:
            return self
        }
        
    }
}

