//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit

class NotificationsViewController: UIViewController, Storyboarded, NibCapable  {
    


    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func backButtonToProfile(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    

}

