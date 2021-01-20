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
    private lazy var headerContentView: HeaderSettingsTableViewCell = .fromNib()
    lazy var backButton = UIButton()

    let arr = [
        "firstName",
        "secondName",
        "nickname",
        "birthday",
        "country",
        "city",
        "address",
        "phone",
        "aboutMy",
        "interests",
        "education",
        "prev_job",
        "current_job",
        "aboutUs",
        "skype",
        "facebook",
        "linkedin",
        "twitter",
        "prefer_specializations",
        "educform",
        "education_shift"
            ]

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupCell()

        headerContentView.delegate = self
        headerContentView.frame.size.width = view.frame.width
        headerView.addSubview(headerContentView)
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        guard parent == nil else { return }
        print("Did press Back button")
    }
    
    func setupCell() {

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
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoSettingProfileTableViewCell", for: indexPath) as? InfoSettingProfileTableViewCell
        
        cell?.aboutSelfLabel.text = arr[indexPath.row] + " : "
        cell?.isProfileEditing = isProfileEditing
        
        if indexPath.row.isMultiple(of: 2) {
            cell?.backgroundColor = .systemGray6
        } else {
            cell?.backgroundColor = .white
        }
        
        return cell ?? UITableViewCell()
    }
    
}

extension SettingsProfileViewController: HeaderSettingsTableViewCellDelegate {
    
    func goToProfileScreen() {

        coordinator?.returnToProfileScreen()
    }
    

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
