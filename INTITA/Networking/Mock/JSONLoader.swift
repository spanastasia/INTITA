//
//  JSONLoader.swift
//  INTITA
//
//  Created by Viacheslav Markov on 14.11.2020.
//

import Foundation

class JSONLoader {
    
    static func loadJsonData(file: String?) -> Data? {
        
        if let jsonFilePath = Bundle(for: self).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            
            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        
        return nil
    }
    
}
