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
    func loadNotifications(notificationsType: String) {
        authorizationService.fetchNotifications(notificationsType: notificationsType) { (response) in
            switch response {
                case .success(let notif):
                    self.notifcationsBox = notif.rows
                    self.updateCallback?(nil)
                case .failure(let error):
                    print(error)
                        self.updateCallback?(error)
                    }
        }
    }
}
