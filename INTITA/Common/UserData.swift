//
//  UserData.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import Foundation

class UserData {
    static var token: String? {
        return UserDefaultsManager.getValue(by: AppConstans.tokenKey)
    }
    private(set) static var currentUser: CurrentUser?
    
    static func set(currentUser: CurrentUser) {
        UserData.currentUser = currentUser
    }
    static func reset() {
        UserData.currentUser = nil
        UserDefaultsManager.addValue(nil, by: AppConstans.tokenKey)
    }
}
