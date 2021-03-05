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
    
    func localized(locationType: LocationType, locale: Locale = .current) -> String {
        var valueOptional: LocationProtocol?
        
        switch locationType {
        case .country:
            valueOptional = LocationService<CountryModel>.location(by: self)
        case .city:
            valueOptional = LocationService<CityModel>.location(by: self)
        case .specialization:
            valueOptional = LocationService<SpecializationModel>.location(by: self)
        case .educationShift:
            valueOptional = LocationService<EducationShiftModel>.location(by: self)
        }
        
        guard let value = valueOptional else {
            return self
        }
        
        switch locale.languageCode {
        case "en":
            return value.titleEN
        case "ua":
            return value.titleUA
        case "ru":
            return value.titleRU
        default:
            return self
        }
    }
}

