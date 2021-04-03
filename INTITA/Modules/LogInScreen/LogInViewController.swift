//
//  LogInViewController.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import UIKit

enum LoginCell: Int, CaseIterable {
//    case emptyCellOne
    case logoImageCell
    case emptyCellTwo
    case emailTextFieldCell
//    case emptyCellThree
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
    
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        viewModel?.subscribe(updateCallback: handleViewModelUpdateWith)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        if UserData.token != nil {
            startSpinner()
            viewModel?.fetchUserInfo()
        }
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
        
        tableView.scrollToRow(at: IndexPath(row: LoginCell.loginButtonCell.rawValue, section: 0), at: .bottom, animated: true)
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
        tableView.register(LogoTableViewCell.nib(), forCellReuseIdentifier: LogoTableViewCell.identifier)
        tableView.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        tableView.register(RegisterButtonTableViewCell.nib(), forCellReuseIdentifier: RegisterButtonTableViewCell.identifier)
        tableView.register(LinksTableViewCell.nib(), forCellReuseIdentifier: LinksTableViewCell.identifier)
    }
}

extension LogInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LoginCell.allCases.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let nameCell = LoginCell(rawValue: indexPath.row)
//        var heightCell: CGFloat
//
//        switch nameCell {
//        case .emptyCellOne:
//            heightCell = 45
//        case .logoImageCell:
//            heightCell = 243
//        case .emptyCellTwo:
//            heightCell = 52
//        case .loginButtonCell, .emailTextFieldCell:
//            heightCell = 78
//        case .passwordTextFieldCell:
//            heightCell =  57
//        case .linksButtonCell:
//            heightCell = 40
//        default:
//            heightCell = 20.0
//        }
//        return heightCell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameCell = LoginCell(rawValue: indexPath.row)
        var cell: UITableViewCell?
        
        switch nameCell {
        case .logoImageCell:
            let logoCell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCell.identifier) as? LogoTableViewCell
            logoCell?.authLabel.text = "auth".localized
            cell = logoCell
            
        case .emailTextFieldCell:
            let emailCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier) as? TextTableViewCell
            let cellConfig = TextTableViewCellConfiguration(type: .email, placeholderText: "inputEmail".localized)
            emailCell?.configure(with: cellConfig)
            cell = emailCell
            
        case .passwordTextFieldCell:
            let passwordCell =  tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier) as? TextTableViewCell
            
            let cellConfig = TextTableViewCellConfiguration(type: .password, placeholderText: "inputPassword".localized)
            passwordCell?.configure(with: cellConfig)
            cell = passwordCell
            
        case .linksButtonCell:
            let linksCell = tableView.dequeueReusableCell(withIdentifier: LinksTableViewCell.identifier) as? LinksTableViewCell
            linksCell?.delegate = self
            cell = linksCell
            
        case .loginButtonCell:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: RegisterButtonTableViewCell.identifier) as? RegisterButtonTableViewCell
            buttonCell?.delegate = self
            buttonCell?.logInButton.setTitle("logIn".localized, for: .normal)
            cell = buttonCell
            
        default:
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
}

extension LogInViewController: RegisterButtonTableViewCellDelegate {
    
    func didPressLogInButton(_ sender: RegisterButtonTableViewCell) {
        
        guard let emailCell = tableView.cellForRow(at: IndexPath(row: LoginCell.emailTextFieldCell.rawValue,
                                                                 section: 0)) as? TextTableViewCell,
              let passwordCell = tableView.cellForRow(at: IndexPath(row: LoginCell.passwordTextFieldCell.rawValue,
                                                                    section: 0)) as? TextTableViewCell else { return }
        
        emailCell.textField.resignFirstResponder()
        passwordCell.textField.resignFirstResponder()
        
        guard let password = passwordCell.textField.text, let email = emailCell.textField.text else { return }
        
        if validator.validatePassword(password: password), validator.validateEmail(email: email) {
            startSpinner()
            viewModel?.login(email: email, password: password)
            return
        }
        
        if !validator.validateEmail(email: email) {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
        }
        
        if !validator.validatePassword(password: password) {
            passwordCell.errorLabel.isHidden = false
            passwordCell.errorImage.isHidden = false
            passwordCell.errorLabel.text = CredentialsError.wrongPassword.getString()
            passwordCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
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
