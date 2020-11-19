//
//  ProfileViewController.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileViewController: UITableViewController, Storyboarded {
    private let rowNumber = 6
    private let alert: AlertView = .fromNib()
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if #available(iOS 13, *) {
            let statusBar = UIView(frame: (UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor.primaryColor
            UIApplication.shared.windows[0].addSubview(statusBar)
        } else {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = UIColor.primaryColor
            }
        }
        
        startSpinner()
        DispatchQueue.main.async {
            self.viewModel?.fetchUserInfo()
        }
        view.addSubview(alert)
        view.bringSubviewToFront(alert)
        viewModel?.delegate = self
        viewModel?.subscribe(updateCallback: handleError)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileHeaderView", bundle: nil), forCellReuseIdentifier: "ProfileHeaderView")
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(UINib(nibName: "ProfileFooterView", bundle: nil), forCellReuseIdentifier: "ProfileFooterView")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewHeigh = view.safeAreaLayoutGuide.layoutFrame.height
        switch indexPath.row {
        case 0:
            return viewHeigh * 0.4
        case rowNumber - 1:
            return 66
        default:
            return (viewHeigh * 0.6 - 66) / 4
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell: UITableViewCell
        switch row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView
            (cell as! ProfileHeaderView).delegate = self
        case rowNumber - 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooterView") as! ProfileFooterView
            (cell as! ProfileFooterView).label.text = "exit".localized
            (cell as! ProfileFooterView).delegate = self
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            setUpCell(cell as! ProfileTableViewCell, row: row)
        }
        return cell
    }
    
    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.alert.customizeAndShow(message: error.localizedDescription)
        }
    }
    
    func setUpCell(_ cell: ProfileTableViewCell, row: Int) {
        if row == 1 {
            cell.button.imageView?.image = UIImage(named: "mail")
            cell.label.text = "messages".localized
        }
        if row == 2 {
            cell.button.imageView?.image = UIImage(named: "trophy")
            cell.label.text = "opportunities".localized
        }
        if row == 3 {
            cell.button.imageView?.image = UIImage(named: "edit")
            cell.label.text = "my tasks".localized
        }
        if row == 4 {
            cell.button.imageView?.image = UIImage(named: "settings")
            cell.label.text = "settings".localized
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func logoutSuccess() {
        DispatchQueue.main.async {
            self.coordinator?.presentLoginScreen()
        }
    }
    
    func fetchUserInfo() {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        stopSpinner()
    }
    
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func editImage() {
        print("edit image")
    }
    
    func avatarTapped() {
        print("avatar tapped")
        //go to system profile
    }
}

extension ProfileViewController: ProfileFooterViewDelegate {
    func logout() {
        viewModel?.logout()
    }
}
