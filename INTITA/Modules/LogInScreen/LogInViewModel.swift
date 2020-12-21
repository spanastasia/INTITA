//
//  LogInViewModel.swift
//  INTITA
//
//  Created by Stepan Niemykin on 05.11.2020.
//

import Foundation

typealias LogInViewModelCallback = (Error?) -> Void

protocol LogInViewModelDelegate: AnyObject {
    func loginSuccess()
}

class LogInViewModel {
    weak var delegate: LogInViewModelDelegate?
    var updateCallback: LogInViewModelCallback?    
    var authorizationService: AuthorizationProtocol = Authorization.shared
    
    func subscribe(updateCallback: LogInViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func login(email: String, password: String) {
        authorizationService.login(email: email, password: password, completion: { [weak self] error in
            if let error = error {
                self?.updateCallback?(error) // 1 [.login: .failing]
            } else {
                self?.fetchUserInfo()        //  ||
            }                                // \  /
        })                                   //  \/
    }
    
    func fetchUserInfo() {
        authorizationService.fetchUserInfo { [weak self] error in
            if let error = error  {
                self?.updateCallback?(error)  // 2 [.login: .mock], [.user, .failing]
            } else {
                self?.delegate?.loginSuccess()// 3 .mock
            }
        }
    }
}
