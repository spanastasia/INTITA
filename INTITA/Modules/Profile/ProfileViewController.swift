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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileHeader", bundle: nil), forCellReuseIdentifier: "ProfileHeader")
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
        var cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeader") as! ProfileHeader
        case rowNumber - 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooter") as! ProfileFooter
            cell.frame.size.height = 66
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        }
        return cell
    }
}
