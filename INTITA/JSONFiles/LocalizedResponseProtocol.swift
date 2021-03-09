//
//  LocalizedResponseProtocol.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 12.02.2021.
//

import Foundation

protocol LocalizedResponseProtocol: Codable {
    var id: Int { get set }
    var titleUA: String { get set }
    var titleRU: String { get set }
    var titleEN: String { get set }
    
    var identifier: String { get }
    static var type: LocationType { get }
    
    func getLocalizedValue() -> String?
}

extension LocalizedResponseProtocol {
    var identifier: String { String(id) }
    
    func getLocalizedValue() -> String? {
        JSONService<Self>.getValue(by: id)?.identifier.localized(locationType: Self.type)
    }
}

enum LocationType {
    case country
    case city
    case specialization
    case educationShift
    
    var fileName: String {
        switch self {
        case .country:
            return "Countries"
        case .city:
            return  "Cities"
        case .specialization:
            return "Specialization"
        case .educationShift:
            return "EducationShift"
        }
    }
}
