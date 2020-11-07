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
}
