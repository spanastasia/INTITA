//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit

class NotificationsViewController: UIViewController, Storyboarded, NibCapable  {
    
    var notifcationsBox : [Messeg] = []
    var displeyCount : [Messeg] = []
    var limit = 20
    
    var authorizationService: AuthorizationProtocol = Authorization.shared

    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTabelView.delegate = self
        notificationTabelView.dataSource = self
        
        authorizationService.fetchNotifications { (response) in
           
            switch response {
            case .success(let notif):
                self.notifcationsBox = notif.rows
            case .failure(let error):
                print(error)
            }
        }

        
        setupCell()
    }
    
    func setupCell() {
        notificationTabelView.register(NotificationsTableViewCell.nib(),
                           forCellReuseIdentifier: NotificationsTableViewCell.identifier)
    }
    

    @IBAction func inbox(_ sender: Any) {
        
    }
    
    @IBAction func send(_ sender: Any) {
        
    }
    
    @IBAction func system(_ sender: Any) {
    }
    
    @IBAction func trash(_ sender: Any) {
    }
    
    @IBAction func backButtonToProfile(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    
    func setupNewView(iN : Int){
        var x = iN
        while x < limit {
            displeyCount.append(notifcationsBox[x])
            x += 1
        }
    }
    
}


extension NotificationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifcationsBox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sabjectLabel.text = notifcationsBox[indexPath.row].subject
        cell.massegLabel.text = notifcationsBox[indexPath.row].messageText
        cell.emailLabel.text = notifcationsBox[indexPath.row].userReceiver.email
        cell.timeLabel.text = notifcationsBox[indexPath.row].createDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
        if indexPath.row == displeyCount.count-1 && notifcationsBox.count != displeyCount.count{
            
           // infinitiScroll

        }
    }

    
    
    
}

extension NotificationsViewController: UITableViewDelegate {

}


