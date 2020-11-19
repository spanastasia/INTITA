//
//  JSONLoader.swift
//  INTITA
//
//  Created by Viacheslav Markov on 14.11.2020.
//

struct Response {
    var email: String?
    var password: String?
}

import Foundation

class JSONLoader {
    
    var data: Data?
    
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
