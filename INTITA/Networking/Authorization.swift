//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

protocol AuthorizationProtocol {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void)
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void)
    func fetchUserInfo(completion: @escaping (Error?) -> Void)
}

class AuthorizationFailing: AuthorizationProtocol {
    
    enum TestError: Error {
        case test
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        completion(TestError.test)
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        completion(.failure(TestError.test))
    }
    
    func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        completion(TestError.test)
    }
}

class AuthorizationMock: AuthorizationProtocol {
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard let file = ApiURL.login(email: email, password: password).mockFileName,
              let data = JSONLoader.loadJsonData(file: file),
              let response = try? JSONDecoder().decode(LoginResponse.self, from: data)
        else { return }
        
        UserDefaultsManager.addValue(response.token, by: AppConstans.tokenKey)
        completion(nil)
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        ///
    }
    
    func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        guard let file = ApiURL.currentUser.mockFileName,
              let data = JSONLoader.loadJsonData(file: file),
              let response = try? JSONDecoder().decode(CurrentUser.self, from: data)
        else {
            return
        }
        
        UserData.set(currentUser: response)
        completion(nil)
    }
    
    
}

class Authorization: AuthorizationProtocol {
    private init(){}
    static let shared = Authorization()
    
    public func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
    
        guard let request = ApiURL.login(email: email, password: password).request
        else { return }
        APIRequest.shared.request(request: request) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let response):
                UserDefaultsManager.addValue(response.token, by: AppConstans.tokenKey)
                completion(nil)
            }
        }
    }
    
    public func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        guard let request = ApiURL.logout.request else { return }
        APIRequest.shared.request(request: request) { (result: Result<LogoutResponse, Error>) in
            switch result {
            case .success(_):
                UserData.reset()
                fallthrough
            default:
                completion(result)
            }
        }
    }
    
    public func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        guard let request = ApiURL.currentUser.request else { return }
        APIRequest.shared.request(request: request) { (result: Result<CurrentUser, Error>) in
            switch result {
            case .success(let user):
                UserData.set(currentUser: user)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
