//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit


protocol NotificationsDelegate: AnyObject {
    func loadNotifications()
}



class NotificationsViewController: UIViewController, Storyboarded, NibCapable {
    
    weak var del : NotificationsDelegate?
    
    var viewModel : NotificationsViewModel?
    
    
    
    var notifcationsBox : [Messeg] = []
    var authorizationService: AuthorizationProtocol = Authorization.shared
    
    

    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTabelView.delegate = self
        notificationTabelView.dataSource = self

        setupCell()
        loadNotifications()
    }
    
    func loadNotifications() {
        authorizationService.fetchNotifications { (response) in
            switch response {
                case .success(let notif):
                    self.notifcationsBox = notif.rows
                    DispatchQueue.main.async {
                        self.notificationTabelView.reloadData()
                    //self.notificationTabelView.reloadData()
                    }
                    case .failure(let error):
                        print(error)
                    }
        }
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
    

}


extension NotificationsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard let section = viewModel?.notifcationsBox.count else { return 0}
        //return  section
        notifcationsBox.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sabjectLabel.text = viewModel?.notifcationsBox[indexPath.row].subject
        cell.massegLabel.text = viewModel?.notifcationsBox[indexPath.row].messageText
        cell.emailLabel.text = viewModel?.notifcationsBox[indexPath.row].userReceiver.email
        cell.timeLabel.text = viewModel?.notifcationsBox[indexPath.row].createDate
        
        
        cell.sabjectLabel.text = notifcationsBox[indexPath.row].subject
        cell.massegLabel.text = notifcationsBox[indexPath.row].messageText
        cell.emailLabel.text = notifcationsBox[indexPath.row].userReceiver.email
        cell.timeLabel.text = notifcationsBox[indexPath.row].createDate
        

    
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {



//        if indexPath.row == displeyCount.count-1 && notifcationsBox.count != displeyCount.count{

           // infinitiScroll

//        }
    }




}

extension NotificationsViewController: UITableViewDelegate {

}
