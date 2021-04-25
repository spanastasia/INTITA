//
//  SettingsProfileViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

class SettingsProfileViewController: UIViewController, Storyboarded {
    
    var coordinator: SettingsProfileCoordinator?
    
    private lazy var headerContentView: HeaderSettingsTableViewCell = .fromNib()

    var viewModel: SettingsProfileViewModel!

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCell()
        setupHeaderTableView()

        headerContentView.delegate = self
        headerContentView.frame.size.width = view.frame.width
        headerView.addSubview(headerContentView)
        
        viewModel.subscribe { error in
            if let error = error {
                print(error)
                return
            }
            self.tableView.reloadData()
        }
        
    }
    
//    override func didMove(toParent parent: UIViewController?) {
//        super.didMove(toParent: parent)
//
//        guard parent == nil else { return }
//        print("Did press Back button")
//    }
    
    func setupHeaderTableView() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        header.backgroundColor = .systemGray6
        
        let label = UILabel(frame: CGRect(x: 28, y: 8, width: view.frame.width - 16, height: 20))
        label.text = "system_profile".localized
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    
    func setupCell() {
//        tableView.register(InfoSettingProfileTableViewCell.nib(),
//                           forCellReuseIdentifier: InfoSettingProfileTableViewCell.identifier)
    }

}

extension SettingsProfileViewController: UITableViewDelegate {
    
}

extension SettingsProfileViewController: HeaderSettingsTableViewCellDelegate {
    
    func goToProfileScreen() {
        coordinator?.returnToProfileScreen()
    }
    
    func editTaped(_ sender: HeaderSettingsTableViewCell) {
        
        viewModel.startEditUser()
        sender.setupEditBtn(isTrue: viewModel.isProfileEditing)
        
//        if !viewModel.isProfileEditing {
//            viewModel.putEditingUser()
//        }
    }
}
