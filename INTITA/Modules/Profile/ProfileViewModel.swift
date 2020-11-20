//
//  ProfileViewModel.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import Foundation

typealias ProfileViewModelCallback = (Error) -> Void

protocol ProfileViewModelDelegate: AnyObject {
    func logoutSuccess()
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    private var updateCallback: ProfileViewModelCallback?
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func logout() {
        Authorization.logout { result in
            switch result {
            case .success(_):
                self.delegate?.logoutSuccess()
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }
}
