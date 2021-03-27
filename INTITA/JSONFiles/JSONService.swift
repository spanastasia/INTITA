//
//  JSONService.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 12.02.2021.
//

import Foundation

class JSONService<T: LocalizedResponseProtocol> {
    
    static var values: [T]? {
        var values: [T]?
        guard let path = Bundle.main.url(forResource: T.type.fileName, withExtension: "json") else {
            return nil
        }
        
        guard let json = try? Data(contentsOf: path) else { return nil}
        let decoder = JSONDecoder()
        
        do {
            values = try decoder.decode([T].self, from: json)
        } catch {
            print(error.localizedDescription)
        }
        
        return values
    }
    
    static func getValue(by identifier: String?) -> T? {
        return values?.first { $0.identifier == identifier }
    }
    
    static func getValue(by id: Int?) -> T? {
        return values?.first{ $0.id == id }
    }
}

