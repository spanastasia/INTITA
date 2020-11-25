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

class AuthorizationMock: AuthorizationProtocol {
    //var error: Error?
    
    var didCall_Login: (() -> ())?
    var didCall_logout: (() -> ())?
    var didCall_fetchUserInfo: (() -> ())?
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        //completion(error)
        didCall_Login?()
    }
    
    func logout(completion: @escaping (Result<LogoutResponse, Error>) -> Void) {
        didCall_logout?()
    }
    
    func fetchUserInfo(completion: @escaping (Error?) -> Void) {
        didCall_fetchUserInfo?()
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
