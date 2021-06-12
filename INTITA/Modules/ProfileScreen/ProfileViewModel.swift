//
//  ProfileViewModel.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import Foundation

typealias ProfileViewModelCallback = (Error?) -> Void

protocol ProfileViewModelDelegate: AnyObject {
    func logoutSuccess()
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    private var updateCallback: ProfileViewModelCallback?
    var authorizationService: AuthorizationProtocol
    
    var user = UserData.currentUser
    
    init(authorizationService: AuthorizationProtocol = Authorization.shared) {
        self.authorizationService = authorizationService
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func fetchUser() {
        if let updateCallback = updateCallback {
            Authorization.shared.fetchUserInfo { result in
                if case Result.failure(let error) = result {
                    DispatchQueue.main.async {
                        updateCallback(error)
                    }
                }
            }
        }
    }
    
    func getSpecialization() -> String {
        let firstSpecialization = user?.preferSpecializations.first?.specialization.id
        guard let specializationString = JSONService<SpecializationModel>
                .getValue(by: firstSpecialization)?
                .getLocalizedValue() else { return "" }
        return specializationString
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
    
    func setUser(at user: CurrentUser) {
        self.user = user
    }
}
