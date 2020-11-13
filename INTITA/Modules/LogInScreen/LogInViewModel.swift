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
    
    func subscribe(updateCallback: LogInViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func login(email: String, password: String) {
        Authorization.login(email: email, password: password, completion: { error in
            if let error = error {
                self.updateCallback?(error)
            } else {
                self.delegate?.loginSuccess()
            }
        })
    }
    
}
