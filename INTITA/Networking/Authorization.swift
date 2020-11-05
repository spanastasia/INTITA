//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

class Authorization {
    private static let defaults = UserDefaultsManager.instance
    
    public static func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard let request = ApiURL.login(email: email, password: password).request
        else { return }
        RequestAPI.request(request: request) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let response):
                defaults.token = response.token
                completion(nil)
            }
        }
    }
    
    public static func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        guard let request = ApiURL.logout.request else { return }
        RequestAPI.request(request: request) { (result: Result<LogoutResponse, Error>) in
            completion(result)
        }
    }
}
