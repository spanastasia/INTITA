//
//  SettingsProfileViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

class SettingsProfileViewController: UIViewController, Storyboarded {
    
    var coordinator: SettingsProfileCoordinator?
    private var isProfileEditing = false

    let arr = [
                "firstName", "full_name", "secondName",
                "nickname", "birthday", "email",
                "facebook", "linkedin", "twitter",
                "phone", "address", "education",
                "aboutUs", "aboutMy", "avatar",
                "skype", "country", "city",
                "current_job", "userStatus"
            ]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupCell()
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        navigationController?.navigationBar.barTintColor = UIColor.primaryColor

    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        guard parent == nil else { return }
        print("Did press Back button")
    }
    
    func setupCell() {
        
        tableView.register(HeaderSettingsTableViewCell.nib(),
                           forCellReuseIdentifier: HeaderSettingsTableViewCell.identifier)

        tableView.register(InfoSettingProfileTableViewCell.nib(),
                           forCellReuseIdentifier: InfoSettingProfileTableViewCell.identifier)
    }

}

extension SettingsProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tappet \(indexPath.row) cell")
    }
}

extension SettingsProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if indexPath.row == 0 {
            height = 188
        } else {
            height = 45
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderSettingsTableViewCell", for: indexPath) as! HeaderSettingsTableViewCell
            
            headerCell.delegate = self
            return headerCell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoSettingProfileTableViewCell", for: indexPath) as! InfoSettingProfileTableViewCell
            cell.aboutSelfLabel.text = arr[indexPath.row] + " : "
            cell.isProfileEditing = isProfileEditing
            if indexPath.row.isMultiple(of: 2) {
                cell.backgroundColor = .systemGray6
            }
            
            return cell
        }
        
    }
    
}

extension SettingsProfileViewController: HeaderSettingsTableViewCellDelegate {

    func editTaped(_ sender: HeaderSettingsTableViewCell) {
        
        isProfileEditing.toggle()
        
        if sender.editButton.titleLabel?.text == "edit".localized {
            sender.editButton.setTitle("save".localized, for: .normal)
        } else {
            sender.editButton.setTitle("edit".localized, for: .normal)
        }
        tableView.reloadData()
    }
}
