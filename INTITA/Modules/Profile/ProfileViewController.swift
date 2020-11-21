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
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorStatusBar(UIColor.primaryColor)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(alert)
        
        viewModel?.delegate = self
        viewModel?.subscribe(updateCallback: handleError)
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        colorStatusBar(UIColor.systemBackground)
    }
    
    //MARK: - TableView settings
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView
            cell?.dataSourse = self
            cell?.delegate = coordinator
            return cell ?? UITableViewCell()
        case rowNumber - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFooterView") as? ProfileFooterView
            cell?.label.text = "exit".localized
            cell?.delegate = viewModel
            return cell ?? UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell
            setUpProfileBodyCell(cell, row: row)
            return cell ?? UITableViewCell()
        }
    }
    
    //MARK: - Error handling
    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.alert.customizeAndShow(message: error.localizedDescription)
        }
    }
    
    //MARK: - Private methods
    private func setUpProfileBodyCell(_ cell: ProfileTableViewCell?, row: Int) {
        cell?.row = row
        if row == 1 {
            cell?.button.imageView?.image = UIImage(named: "mail")
            cell?.label.text = "messages".localized
        }
        if row == 2 {
            cell?.button.imageView?.image = UIImage(named: "trophy")
            cell?.label.text = "opportunities".localized
        }
        if row == 3 {
            cell?.button.imageView?.image = UIImage(named: "edit")
            cell?.label.text = "my tasks".localized
        }
        if row == 4 {
            cell?.button.imageView?.image = UIImage(named: "settings")
            cell?.label.text = "settings".localized
        }
    }
    
    private func colorStatusBar(_ color: UIColor) {
        if #available(iOS 13, *) {
            let statusBar = UIView(frame: (UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = color
            UIApplication.shared.windows[0].addSubview(statusBar)
        } else {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "ProfileHeaderView", bundle: nil), forCellReuseIdentifier: "ProfileHeaderView")
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(UINib(nibName: "ProfileFooterView", bundle: nil), forCellReuseIdentifier: "ProfileFooterView")
    }
}

//MARK: - Extentions
extension ProfileViewController: ProfileViewModelDelegate {
    func logoutSuccess() {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.coordinator?.showLoginScreen()
        }
    }
}

extension ProfileViewController: ProfileHeaderViewDataSourse {
    func editImage() {
        print("edit image")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.isEditing = true
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = .fullScreen
        present(imagePickerController, animated: true)
        
        colorStatusBar(UIColor.systemBackground)
    }
}

extension ProfileViewController: (UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        colorStatusBar(UIColor.primaryColor)
    }
}
