//
//  NotificationsViewController.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit


protocol NotificationsDelegate: AnyObject {
    func loadNotifications(notificationsType: String, pageNumber:Int)
}

class NotificationsViewController: UIViewController, Storyboarded, NibCapable, AlertAcceptable {
    
    weak var del : NotificationsDelegate?
    
    var viewModel : NotificationsViewModel?

    @IBOutlet weak var nameNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTabelView: UITableView!
    
    var coordinator: NotificationsCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTabelView.delegate = self
        notificationTabelView.dataSource = self

        setupCell()
        
        viewModel?.subscribe(updateCallback: { (erorr) in
            DispatchQueue.main.async {
                if let erorr = erorr{
                    self.showAlert(message: erorr.localizedDescription)
                }
            self.notificationTabelView.reloadData()
            }
        })
        
        viewModel!.loadNotifications(notificationsType: NotificationsType.inbox.rawValue, pageNumber: viewModel!.pageCounter )
        
    }
    
    
    
    func setupCell() {
        notificationTabelView.register(NotificationsTableViewCell.nib(),
                           forCellReuseIdentifier: NotificationsTableViewCell.identifier)
    }
    
    
    

    @IBAction func inbox(_ sender: Any) {
        viewModel?.loadNotifications(notificationsType: NotificationsType.inbox.rawValue, pageNumber: viewModel!.pageCounter )
        DispatchQueue.main.async {
            self.notificationTabelView.reloadData()
        }
    }
    
    @IBAction func send(_ sender: Any) {
        viewModel?.loadNotifications(notificationsType: NotificationsType.sent.rawValue, pageNumber: viewModel!.pageCounter )
        DispatchQueue.main.async {
            self.notificationTabelView.reloadData()
        }
    }
    
    @IBAction func system(_ sender: Any) {
        viewModel?.loadNotifications(notificationsType: NotificationsType.system.rawValue, pageNumber: viewModel!.pageCounter )
        DispatchQueue.main.async {
            self.notificationTabelView.reloadData()
        }
    }
    
    @IBAction func trash(_ sender: Any) {
        viewModel?.loadNotifications(notificationsType: NotificationsType.trash.rawValue, pageNumber: viewModel!.pageCounter )
        DispatchQueue.main.async {
            self.notificationTabelView.reloadData()
        }
        
    }
    
    @IBAction func backButtonToProfile(_ sender: Any) {
        coordinator?.returnToProfileScreen()
    }
    

}


extension NotificationsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel?.notifcationsBox.count else { return 0}
        return  section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as? NotificationsTableViewCell else {
            return UITableViewCell()
        }
        
        //viewModel!.setupView(iN: viewModel!.indexx)
        cell.sabjectLabel.text = viewModel?.notifcationsBox[indexPath.row].subject
        cell.massegLabel.text = viewModel?.notifcationsBox[indexPath.row].messageText
        cell.emailLabel.text = viewModel?.notifcationsBox[indexPath.row].userReceiver.email
        cell.timeLabel.text = viewModel?.notifcationsBox[indexPath.row].createDate
        
        
    
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("@@@@@@@@@@@@@@@")
        //print("viewModel?.notifcationsBox.count\(viewModel?.notifcationsBox.count)")
        print("vindexPath.row\(indexPath.row)")

        if indexPath.row == (viewModel?.notifcationsBox.count)!-1  {
            //&& viewModel?.notifcationsBox.count != viewModel?.displeyCount.count
            print("^^^^^^^^^^^^^^^^^^")
//            var newIndex = (viewModel?.displeyCount.count)! - 1
//
//            if newIndex + 20 > (viewModel?.notifcationsBox.count)!-1{
//                viewModel?.limit = (viewModel?.notifcationsBox.count)! - 1
//        }
//        else{
//            viewModel?.limit = newIndex+20
//        }
//            viewModel!.loadNotifications(notificationsType: NotificationsType.sent.rawValue, pageNumber: viewModel!.pageCounter )
            //viewModel?.setupView(iN: newIndex)
        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
       }
    }
    @objc func loadTable() {
        self.notificationTabelView.reloadData()
    }


}

extension NotificationsViewController: UITableViewDelegate {

}
