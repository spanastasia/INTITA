//
//  ProfileViewModel.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import Foundation

typealias ProfileViewModelCallback = (Error?) -> Void

protocol ProfileViewModelDelegate: AnyObject {
    func fetchUserInfo()
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    var updateCallback: ProfileViewModelCallback?
    
    func fetchUserInfo() {
        Authorization.fetchUserInfo { error in
            if error != nil {
                self.updateCallback?(error)
            } else {
                self.delegate?.fetchUserInfo()
            }
        }
    }
}
