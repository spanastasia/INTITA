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
    var startSpinnerCallback: (() -> ())?
    var stopSpinnerCallback: (() -> ())?
    
    func subscribe(updateCallback: LogInViewModelCallback?,
                   startSpinnerCallback: (() -> ())?,
                   stopSpinnerCallback: (() -> ())? ) {
        self.updateCallback = updateCallback
        self.startSpinnerCallback = startSpinnerCallback
        self.stopSpinnerCallback = stopSpinnerCallback
    }
    
    func login(email: String, password: String) {
        startSpinnerCallback?()
        Authorization.login(email: email, password: password, completion: { [weak self] error in
            self?.stopSpinnerCallback?()
            if let error = error {
                self?.updateCallback?(error)
            } else {
                self?.delegate?.loginSuccess()
            }
        })
    }
    
}
