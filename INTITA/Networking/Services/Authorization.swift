//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

enum HTTPType {
    case real
    
    case mock
    case fail
    
    var service: AuthorizationProtocol {
        switch self {
        case .real:
            return AuthorizationReal.shared
        case .mock:
            return AuthorizationMock()
        case .fail:
            return AuthorizationFailing()
        }
    }
}

protocol AuthorizationProtocol {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void)
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void)
    func fetchUserInfo(completion: @escaping (Error?) -> Void)
}

final class Authorization: AuthorizationProtocol {
    
    static let shared: AuthorizationProtocol = Authorization()
   
    enum Method: CaseIterable {
        case login
        case logout
        case user
        
        static var realConfigurations: [Method: HTTPType] {
            var result: [Method: HTTPType] = [:]
            
            Method.allCases.forEach { result[$0] = .real }
            
            return result
        }
    }
    
    var configurations: [Method: HTTPType]
    
    init(configurations: [Method: HTTPType] = Method.realConfigurations) {
        self.configurations = configurations
    }
    
    init(type: HTTPType) {
        var result: [Method: HTTPType] = [:]
        
        Method.allCases.forEach { result[$0] = type }
        
        configurations = result
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        configurations[.login]?.service.login(email: email, password: password, completion: completion)
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        configurations[.logout]?.service.logout(completion: completion)
    }
    
    func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        configurations[.user]?.service.fetchUserInfo(completion: completion)
    }
}

fileprivate class AuthorizationReal: AuthorizationProtocol {
    private init(){}
    static let shared = AuthorizationReal()
    
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

fileprivate class AuthorizationFailing: AuthorizationProtocol {
    
    enum TestError: Error, LocalizedError {
        case login
        case logout
        case user
        
        var errorDescription: String? {
            switch self {
            case .login:
                return "Login error occured..."
            case .logout:
                return "Logout error occured..."
            case .user:
                return "User error occured..."
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        completion(TestError.login)
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        completion(.failure(TestError.logout))
    }
    
    func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        completion(TestError.user)
    }
}

fileprivate class AuthorizationMock: AuthorizationProtocol {
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard let file = ApiURL.login(email: email, password: password).mockFileName,
              let data = JSONLoader.loadJsonData(file: file),
              let response = try? JSONDecoder().decode(LoginResponse.self, from: data)
        else { return }
        
        UserDefaultsManager.addValue(response.token, by: AppConstans.tokenKey)
        completion(nil)
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        //
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
