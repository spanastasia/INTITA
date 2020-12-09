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
    var authorizationService: AuthorizationProtocol
    
    init(authorizationService: AuthorizationProtocol = Authorization()) {
        self.authorizationService = authorizationService
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
}

extension ProfileViewModel: ProfileFooterViewCellDelegate {
    func logout() {
        authorizationService.logout { result in
            switch result {
            case .success(_):
                self.delegate?.logoutSuccess()
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }
}
