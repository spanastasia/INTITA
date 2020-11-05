//
//  UserDefaultsManager.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import Foundation

class UserDefaultsManager {
    private let defaults = UserDefaults.standard
    private var tokenKey = "intitaToken"
    
    var token: String? {
        get {
            defaults.string(forKey: tokenKey)
        }
        set {
            defaults.set(newValue, forKey: tokenKey)
        }
    }
    static var instance = UserDefaultsManager()
    
    private init() {
    }
}
