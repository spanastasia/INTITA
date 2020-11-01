//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation
class Authorization {
    public static func login(email: String, password: String) {
        guard let url = URL(string: RequestAPI.loginPath)
        else {
            return
        }
        let data = RequestAPI.prepareData(email: email, password: password)
        RequestAPI.request(url: url, jsonData: data) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let value):
                print(value.token)
            case .failure(let error):
                print(error)
            }
        }
    }
    public static func logout(email: String) {
        guard let url = URL(string: RequestAPI.logoutPath)
        else {
            return
        }
        //do smth
    }
}
