//
//  LogInViewController.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import UIKit

enum LoginCells: Int {
    case logoImageCell = 0
    case emptyCellOne
    case emailTextFieldCell
    case emptyCellTwo
    case passwordTextFieldCell
    case linksButtonCell
    case loginButtonCell
}

enum CredentialsError {
    case wrongPassword
    case emailIsEmpty
    case wrongEmail
    
    func getString() -> String {
        switch self {
        case .wrongPassword:
            return "wrongPassword".localized
        case .emailIsEmpty:
            return "inputEmail".localized
        case .wrongEmail:
            return "wrongEmail".localized
        }
    }
}

class LogInViewController: UIViewController, Storyboarded, AlertAcceptable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var coordinator: LogInCoordinator?
    var viewModel: LogInViewModel?
    let validator = Validate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserData.token != nil {
            startSpinner()
            viewModel?.fetchUserInfo()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        viewModel?.subscribe(updateCallback: handleViewModelUpdateWith)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startMonitoringKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        stopMonitoringKeyboard()
        stopSpinner()
    }
    
    override func animateKeyboardAppearance(height: CGFloat) {
        tableViewBottomContraint.constant = height
        view.layoutSubviews()
        
        tableView.scrollToRow(at: IndexPath(row: 5, section: 0), at: .bottom, animated: true)
    }
    
    func handleViewModelUpdateWith(error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.stopSpinner()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func registerCells() {
        let logoCell = UINib(nibName: "LogoTableViewCell", bundle: nil)
        let textCell = UINib(nibName: "TextTableViewCell", bundle: nil)
        let registerButtonCell = UINib(nibName: "RegisterButtonTableViewCell", bundle: nil)
        let linksCell = UINib(nibName: "LinksTableViewCell", bundle: nil)
        tableView.register(logoCell, forCellReuseIdentifier: "reuseForLogo")
        tableView.register(textCell, forCellReuseIdentifier: "reuseForText")
        tableView.register(registerButtonCell, forCellReuseIdentifier: "reuseForButton")
        tableView.register(linksCell, forCellReuseIdentifier: "reuseForLinks")
    }
}

extension LogInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let nameCell = LoginCells(rawValue: indexPath.row)
        var heightCell: CGFloat
        
        switch nameCell {
        case .logoImageCell:
            heightCell = 243
        case .emptyCellOne:
            heightCell = 52
        case .loginButtonCell, .emailTextFieldCell:
            heightCell = 78
        case .passwordTextFieldCell:
            heightCell =  57
        case .linksButtonCell:
            heightCell = 40
        default:
            heightCell = 20.0
        }
        return heightCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameCell = LoginCells(rawValue: indexPath.row)
        var cell: UITableViewCell?
        
        switch nameCell {
        case .logoImageCell:
            guard let logoCell = tableView.dequeueReusableCell(withIdentifier: "reuseForLogo") as? LogoTableViewCell else { return UITableViewCell() }
            logoCell.authLabel.text = "auth".localized
            cell = logoCell
            
        case .emailTextFieldCell:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            let cellConfig = TextTableViewCellConfiguration(type: .email, placeholderText: "inputEmail".localized)
            emailCell.configure(with: cellConfig)
            cell = emailCell
            
        case .passwordTextFieldCell:
            guard let passwordCell =  tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            
            let cellConfig = TextTableViewCellConfiguration(type: .password, placeholderText: "inputPassword".localized)
            passwordCell.configure(with: cellConfig)
            cell = passwordCell
            
        case .linksButtonCell:
            guard let linksCell = tableView.dequeueReusableCell(withIdentifier: "reuseForLinks") as? LinksTableViewCell else { return UITableViewCell() }
            linksCell.delegate = self
            cell = linksCell
            
        case .loginButtonCell:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: "reuseForButton") as? RegisterButtonTableViewCell else { return UITableViewCell() }
            buttonCell.delegate = self
            buttonCell.logInButton.setTitle("logIn".localized, for: .normal)
            cell = buttonCell
            
        default:
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
}

extension LogInViewController: RegisterButtonTableViewCellDelegate {
    
    func didPressLogInButton(_ sender: RegisterButtonTableViewCell) {
        
        guard let emailCell = tableView.cellForRow(at: IndexPath(row: 2,
                                                                 section: 0)) as? TextTableViewCell,
              let passwordCell = tableView.cellForRow(at: IndexPath(row: 4,
                                                                    section: 0)) as? TextTableViewCell else { return }
        
        emailCell.textField.resignFirstResponder()
        passwordCell.textField.resignFirstResponder()
        
        guard let password = passwordCell.textField.text, let email = emailCell.textField.text else { return }
        
        if (!validator.validateEmail(email: email)) && (email != "") {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else if (!validator.validatePassword(password: password))  && (password != "") {
            passwordCell.errorLabel.isHidden = false
            passwordCell.errorImage.isHidden = false
            passwordCell.errorLabel.text = CredentialsError.wrongPassword.getString()
            passwordCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else if email == "" {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.emailIsEmpty.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else if password == "" {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongPassword.getString()
            passwordCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else {
            startSpinner()
            viewModel?.login(email: email, password: password)
        }
    }

}

extension LogInViewController: LinksTableViewCellDelegate {
    func linksTableViewCellDidPressRegister(_ sender: LinksTableViewCell) {
        showAlert()
    }
    
    func linksTableViewCellDidPressForgotPassword(_ sender: LinksTableViewCell) {
        coordinator?.forgotPasswordScreen()
    }
}
