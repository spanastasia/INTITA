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

    var viewModel = SettingsProfileViewModel()

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
        
        if indexPath.row == 4 && isProfileEditing {
            coordinator?.showCountryScreen()
        }
    }
}

extension SettingsProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfStates
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoSettingProfileTableViewCell.identifier, for: indexPath) as? InfoSettingProfileTableViewCell else {
            return UITableViewCell()
        }
        
        if let type = EditingFild(rawValue: indexPath.row)?.editType {
            cell.type = type
        }

        cell.configure(withTitle: viewModel.arrayItems[indexPath.row] + " : ",
                        isEditing: isProfileEditing,
                        indexPath: indexPath.row)
        
        return cell
    }
    
}

extension SettingsProfileViewController: HeaderSettingsTableViewCellDelegate {
    
    func goToProfileScreen() {
        coordinator?.returnToProfileScreen()
    }
    
    func editTaped(_ sender: HeaderSettingsTableViewCell) {
        
        isProfileEditing.toggle()
        sender.setupEditBtn(isTrue: isProfileEditing)
        tableView.reloadData()
    }
}
