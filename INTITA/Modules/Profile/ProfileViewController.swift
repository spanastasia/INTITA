//
//  ProfileViewController.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileViewController: UITableViewController, Storyboarded {
    private let rowNumber = 6
    
    weak var coordinator: ProfileCoordinator?
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start spinner
        
        viewModel?.delegate = self
        
        DispatchQueue.main.async { [self] in
            viewModel?.fetchUserInfo()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileHeaderView", bundle: nil), forCellReuseIdentifier: "ProfileHeaderView")
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(UINib(nibName: "ProfileFooter", bundle: nil), forCellReuseIdentifier: "ProfileFooter")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(tableView.visibleCells[0])
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
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooter") as! ProfileFooter
            (cell as! ProfileFooter).label.text = "exit".localized
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            setUpCell(cell as! ProfileTableViewCell, row: row)
        }
        return cell
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
    func fetchUserInfo() {
        //hide spinner
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
