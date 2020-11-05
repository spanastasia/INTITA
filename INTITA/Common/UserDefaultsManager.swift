//
//  UserDefaultsManager.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import Foundation

protocol StorageProtocol {
    static func addValue(_ value: Any?, by key: String)
    static func getValue(by key: String) -> String?

}

class UserDefaultsManager: StorageProtocol {
    
    private static let defaults = UserDefaults.standard
    
    static func addValue(_ value: Any?, by key: String) {
        defaults.set(value, forKey: key)
    }
    
    static func getValue(by key: String) -> String? {
        return defaults.string(forKey: key)
    }
}
