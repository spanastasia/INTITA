//
//  NotificationsViewModel.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.05.2021.
//

import Foundation

typealias ViewModelCallback = (Error?) -> Void

class NotificationsViewModel{
    
    private var updateCallback: ViewModelCallback?
    var notifcationsBox : [Messeg] = []
    var authorizationService: AuthorizationProtocol
    
    init(authorizationService: AuthorizationProtocol = Authorization.shared) {
        self.authorizationService = authorizationService
    }
    
    var viewCont: NotificationsViewController?
    
   
    
    /*
     viewModel.subscribe { error in
     // e.g. ...reloadData()
     }
     */
    
   
    
}

extension NotificationsViewModel: NotificationsDelegate{
    func loadNotifications() {
        authorizationService.fetchNotifications { (response) in
            switch response {
                case .success(let notif):
                    self.notifcationsBox = notif.rows
                    //DispatchQueue.main.async {
                        self.viewCont?.notificationTabelView.reloadData()
                    //self.notificationTabelView.reloadData()
                    //}
                    case .failure(let error):
                        print(error)
                    }
        }
    }
}
