//
//  NotificationsViewModel.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.05.2021.
//

import Foundation

typealias NotificationsViewModelCallback = (Error?) -> Void

class NotificationsViewModel{
    
    private var updateCallback: NotificationsViewModelCallback?
    var notifcationsBox : [Messeg] = []
    var authorizationService: AuthorizationProtocol
    
    var viewCont: NotificationsViewController?
    
    init(authorizationService: AuthorizationProtocol = Authorization.shared) {
        self.authorizationService = authorizationService
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
   
    
}

extension NotificationsViewModel: NotificationsDelegate{
    func loadNotifications() {
        authorizationService.fetchNotifications { (response) in
            switch response {
                case .success(let notif):
                    self.notifcationsBox = notif.rows
                    self.updateCallback?(nil)
                case .failure(let error):
                        self.updateCallback?(error)
                    }
        }
    }
}
