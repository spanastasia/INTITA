//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

class ForgotPasswordViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ForgotPasswordCoordinator?
    
    var validateEmail = Validate()
    
    let spasing: CGFloat = 40
    
    @IBOutlet weak var forgotTableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(view.frame.width, view.frame.height)
        
        forgotTableView.delegate = self
        forgotTableView.dataSource = self
        
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardDidAppear),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardDidDissapear),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
    }
    
    func registerCells() {
        let logoCell = UINib(nibName: "LogoForgotTableViewCell", bundle: nil)
        forgotTableView.register(logoCell, forCellReuseIdentifier: "LogoForgotTableViewCell")
        
        let passCell = UINib(nibName: "PassRecoveryTableViewCell", bundle: nil)
        forgotTableView.register(passCell, forCellReuseIdentifier: "PassRecoveryTableViewCell")
        
        let textCell = UINib(nibName: "ExplanationTableViewCell", bundle: nil)
        forgotTableView.register(textCell, forCellReuseIdentifier: "ExplanationTableViewCell")
        
        let linksCell = UINib(nibName: "TextTableViewCell", bundle: nil)
        forgotTableView.register(linksCell, forCellReuseIdentifier: "reuseForText")
        
        let registerButtonCell = UINib(nibName: "SendButtonTableViewCell", bundle: nil)
        forgotTableView.register(registerButtonCell, forCellReuseIdentifier: "SendButtonTableViewCell")
    }
    
}

    extension ForgotPasswordViewController: UITableViewDelegate {
        
    }

extension ForgotPasswordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 1:
            guard let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoForgotTableViewCell") as? LogoForgotTableViewCell else { return UITableViewCell() }
            return logoCell
        case 3:
            guard let passRecoveryCell = tableView.dequeueReusableCell(withIdentifier: "PassRecoveryTableViewCell") as? PassRecoveryTableViewCell else { return UITableViewCell() }
            return passRecoveryCell
        case 5:
            guard let explanationCell = tableView.dequeueReusableCell(withIdentifier: "ExplanationTableViewCell") as? ExplanationTableViewCell else { return UITableViewCell() }
            return explanationCell
        case 6:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            emailCell.textField.placeholder = "inputEmail".localized
            emailCell.textField.textContentType = .emailAddress
            return emailCell
        case 8:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: "SendButtonTableViewCell") as? SendButtonTableViewCell else { return UITableViewCell() }
            buttonCell.delegat = self
            return buttonCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return spasing / 2
        case 1:
            return 93
        case 3:
            return 60
        case 5:
            return 114
        case 6:
            return 125
        case 8:
            return 55
        default:
            return spasing
        }
    }
}

extension ForgotPasswordViewController: SendButtonTableViewCellDelegate {
    
    func didPressSendButton(_ sender: SendButtonTableViewCell) {
        
        guard let emailCell = forgotTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TextTableViewCell else { return }
        
        guard let email = emailCell.textField.text else { return }
        
        if !validateEmail.validateEmail(email: email) {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
        } else {
//            startSpinner()
//            viewModel?.login(email: email, password: password)
        }
    }
    
}
