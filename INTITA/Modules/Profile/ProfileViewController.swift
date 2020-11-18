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
    private var user: CurrentUser?
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load")
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
        switch indexPath.row {
        case 0:
            return 316
        case rowNumber - 1:
            return 66
        default:
            return (view.safeAreaLayoutGuide.layoutFrame.height - 382) / 4
        }
    }
    
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
        user = UserData.currentUser
        print(user)
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
