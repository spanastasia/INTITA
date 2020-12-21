//
//  UserData.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//
import Foundation

enum UserData {
    static var token: String? {
        return UserDefaultsManager.getValue(by: AppConstans.tokenKey)
    }
    static var isFirstTimeUser: Bool {
        get {
            return UserDefaultsManager.getValue(by: AppConstans.isFirstTimeUser) == nil
        }
        set {
            UserDefaultsManager.addValue(newValue ? 1 : 0, by: AppConstans.isFirstTimeUser)
        }
    }
    private(set) static var currentUser: CurrentUser?
    
    static func set(currentUser: CurrentUser) {
        UserData.currentUser = currentUser
        guard let user = UserData.currentUser else {return}
        CoreDataService.saveDataToDB(appUser: user)
    }
    static func reset() {
        UserData.currentUser = nil
        UserDefaultsManager.addValue(nil, by: AppConstans.tokenKey)
    }
}
