//
//  ProfileViewModel.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import Foundation

typealias ProfileViewModelCallback = (Error) -> Void

protocol ProfileViewModelDelegate: AnyObject {
    func fetchUserInfo()
    func logoutSuccess()
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    private var updateCallback: ProfileViewModelCallback?
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func fetchUserInfo() {
        Authorization.fetchUserInfo { error in
            guard let error = error else {
                DispatchQueue.main.async {
                    self.delegate?.fetchUserInfo()
                }
                return
            }
            self.updateCallback?(error)
        }
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
