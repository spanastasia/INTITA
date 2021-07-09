//
//  NotificationsViewModel.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.05.2021.
//

import Foundation

typealias NotificationsViewModelCallback = (Error?) -> Void

class NotificationsViewModel{
    
    var authorizationService: AuthorizationProtocol
    
    private var updateCallback: NotificationsViewModelCallback?
    var viewCont: NotificationsViewController?
    
    var notifcationsBox : [Messeg] = []
    var limit = 20
    var indexx = 0
    var displeyCount: [Messeg] = []
    var pageCounter = 1
    
    
    init(authorizationService: AuthorizationProtocol = Authorization.shared) {
        self.authorizationService = authorizationService
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func setupView(iN : Int){
        var x = iN
        while x < limit && x < notifcationsBox.count {
            displeyCount.append(notifcationsBox[x])
            x += 1
        }
    }
    
}

extension NotificationsViewModel: NotificationsDelegate{
    func loadNotifications(notificationsType: String, pageNumber: Int) {
        authorizationService.fetchNotifications(notificationsType: notificationsType, pageNumber: pageNumber) { (response) in
            switch response {
                case .success(let notif):
                    self.notifcationsBox += notif.rows
                    self.updateCallback?(nil)
                case .failure(let error):
                    print(error)
                        self.updateCallback?(error)
                    }
        }
    }
}
