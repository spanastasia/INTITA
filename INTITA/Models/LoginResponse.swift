//
//  LoginResponse.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

struct LoginResponse: Codable {
    let token: String?
    
    init(token: String) {
        self.token = token
    }
    init() {
        self.token = nil
    }
}
