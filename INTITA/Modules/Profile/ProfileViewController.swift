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
        tableView.register(ProfileHeader.self, forCellReuseIdentifier: "ProfileHeader")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(ProfileFooter.self, forCellReuseIdentifier: "ProfileFooter")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = (tableView.dequeueReusableCell(withIdentifier: "ProfileHeader") as? ProfileHeader) ?? UITableViewCell()
        case rowNumber - 1:
            cell = (tableView.dequeueReusableCell(withIdentifier: "ProfileFooter") as? ProfileFooter) ?? UITableViewCell()
        default:
            cell = (tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell) ?? UITableViewCell()
        }
        return cell
    }
}
