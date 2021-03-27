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
    
    func localized(locationType: LocalizedFile, locale: Locale = .current) -> String {
        var valueOptional: LocalizedResponseProtocol?
        
        switch locationType {
        case .country:
            valueOptional = JSONService<CountryModel>.getValue(by: self)
        case .city:
            valueOptional = JSONService<CityModel>.getValue(by: self)
        case .specialization:
            valueOptional = JSONService<SpecializationModel>.getValue(by: self)
        case .educationShift:
            valueOptional = JSONService<EducationShiftModel>.getValue(by: self)
        case .career:
            valueOptional = JSONService<CareerModel>.getValue(by: self)
        }
        
        guard let value = valueOptional else {
            return self
        }
        
        switch locale.languageCode {
        case "en":
            return value.titleEN
        case "uk":
            return value.titleUA
        case "ru":
            return value.titleRU
        default:
            return self
        }
    }
}

