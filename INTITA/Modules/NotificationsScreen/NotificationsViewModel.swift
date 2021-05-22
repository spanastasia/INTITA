//
//  NotificationsViewModel.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.05.2021.
//

import Foundation

protocol NotificationsViewModelDelegate: AnyObject {
    func loadNotifications()
}

class NotificationsViewModel{
    
    weak var delegate: NotificationsViewModelDelegate?
    
    // viewModel
    var notifcationsBox : [Messeg] = []
//<<<<<<< HEAD
//    var displeyCount : [Messeg] = []
//    var limit = 20
    
//=======
    var displeyCount : [Messeg] = []
    var limit = 20
//>>>>>>> IN-62-Notifications_list
    var authorizationService: AuthorizationProtocol = Authorization.shared
    // viewModel
    
//    func loadNotifications(){
//        authorizationService.fetchNotifications { (response) in
//
//                switch response {
//                case .success(let notif):
//                    self.notifcationsBox = notif.rows
//                    DispatchQueue.main.async {
//                        self.notificationTabelView.reloadData()
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
        
        
    
    /*
     viewModel.subscribe { error in
     // e.g. ...reloadData()
     }
     */
    
    
    //<<<<<<< HEAD
    //    func setupNewView(iN : Int){
    //        var x = iN
    //        while x < limit {
    //            displeyCount.append(notifcationsBox[x])
    //            x += 1
    //        }
    //    }
        
    //=======
        // viewModel
        func setupNewView(iN : Int){
            var x = iN
            while x < limit {
                displeyCount.append(notifcationsBox[x])
                x += 1
            }
        }
        // viewModel
    //>>>>>>> IN-62-Notifications_list
    
}
