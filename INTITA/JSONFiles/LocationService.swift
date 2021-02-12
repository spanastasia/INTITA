//
//  LocationService.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 12.02.2021.
//

import Foundation

class LocationService<T: LocationProtocol> {
    
    static var locations: [T]? {
        var values: [T]?
        guard let path = Bundle.main.url(forResource: resource, withExtension: "json") else { return nil}
        
        guard let json = try? Data(contentsOf: path) else { return nil}
        let decoder = JSONDecoder()
        
        do {
            values = try decoder.decode([T].self, from: json)
        } catch {
            print(error.localizedDescription)
        }
        
        return values
    }
    
    static func location(by identifier: String) -> T? {
        
        let value = locations?.first { $0.identifier == identifier }
        
        return value
    }
    
    private static var resource: String {
        var resource: String
        let typeName = String(describing: T.self)
        
        switch typeName {
        
        case String(describing: CountryModel.self):
            resource = "Countries"
            
        case String(describing: CityModel.self):
            resource = "Cities"
            
        default:
            resource = ""
        }
        
        return resource
    }
}

