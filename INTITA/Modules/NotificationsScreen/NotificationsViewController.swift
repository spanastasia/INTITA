//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit

class NotificationsViewController: UIViewController, Storyboarded, NibCapable  {
    
    var notifcationsBox : [Int] = [1,2]

    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTabelView.delegate = self
        notificationTabelView.dataSource = self

        setupCell()
    }
    
    func setupCell() {
        notificationTabelView.register(NotificationsTableViewCell.nib(),
                           forCellReuseIdentifier: NotificationsTableViewCell.identifier)
    }
    

    @IBAction func backButtonToProfile(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    

}

extension NotificationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return OpportunitiesType.allCases.count
        return notifcationsBox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
}

extension NotificationsViewController: UITableViewDelegate {

}
