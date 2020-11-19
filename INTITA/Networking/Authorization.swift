//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

class Authorization {
    
    public static func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
    
        guard let request = ApiURL.login(email: email, password: password).request
        else { return }
        APIRequest.init().shared.request(request: request) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let response):
                UserDefaultsManager.addValue(response.token, by: AppConstans.tokenKey)
                fetchUserInfo { completion($0) }
            }
        }
    }
    
    public static func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        guard let request = ApiURL.logout.request else { return }
        APIRequest.init().shared.request(request: request) { (result: Result<LogoutResponse, Error>) in
            completion(result)
        }
    }
    
    public static func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        guard let request = ApiURL.currentUser.request else { return }
        APIRequest.init().shared.request(request: request) { (result: Result<CurrentUser, Error>) in
            switch result {
            case .success(let user):
                UserData.set(currentUser: user)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
