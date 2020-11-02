//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation
class Authorization {
    public static func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: RequestAPI.loginPath)
        else {
            return
        }
        let data = RequestAPI.prepareData(email: email, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        RequestAPI.request(request: request) { (result: Result<LoginResponse, Error>) in
            completion(result)
        }
    }
    public static func logout(token: String, completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        guard let url = URL(string: RequestAPI.logoutPath)
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let authValue: String = "Bearer \(token)"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")

        RequestAPI.request(request: request) { (result: Result<LogoutResponse, Error>) in
            completion(result)
        }
    }
}
