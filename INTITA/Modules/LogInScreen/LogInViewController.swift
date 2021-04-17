//
//  LogInViewController.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import UIKit

enum LoginCell: Int, CaseIterable {
    case logoImageCell
    case emailTextFieldCell
    case wrongPasswordEmailCell
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
            return "wrongPasswordWrongEmail".localized
        case .emailIsEmpty:
            return "inputEmail".localized
        case .wrongEmail:
            return "wrongEmailwrongPassword".localized
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
    
    private var isErrorHidden = true
    
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
            isErrorHidden = false
            DispatchQueue.main.async {
                self.stopSpinner()
                self.showAlert(message: error.localizedDescription)
                self.tableView.reloadData()
            }
        }
    }
    
    func registerCells() {
        tableView.register(LogoTableViewCell.nib(), forCellReuseIdentifier: LogoTableViewCell.identifier)
        tableView.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        tableView.register(RegisterButtonTableViewCell.nib(), forCellReuseIdentifier: RegisterButtonTableViewCell.identifier)
        tableView.register(LinksTableViewCell.nib(), forCellReuseIdentifier: LinksTableViewCell.identifier)
        tableView.register(WrongPasswordEmailTableViewCell.nib(), forCellReuseIdentifier: WrongPasswordEmailTableViewCell.identifier)
    }
}

extension LogInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LoginCell.allCases.count
    }
    
    
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
            emailCell?.errorImage.isHidden = isErrorHidden
            let borderColor: UIColor = isErrorHidden ? .black : .red
            emailCell?.textField.bordered(borderWidth: 1, borderColor: borderColor.cgColor)
            emailCell?.delegate = self
            cell = emailCell
            
        case .wrongPasswordEmailCell:
            let wrongCell = tableView.dequeueReusableCell(withIdentifier: WrongPasswordEmailTableViewCell.identifier) as? WrongPasswordEmailTableViewCell
            wrongCell?.errorLabel.textColor = UIColor.red
            wrongCell?.errorLabel.isHidden = isErrorHidden
            wrongCell?.errorLabel.text = isErrorHidden ? "" : CredentialsError.wrongEmail.getString()
            cell = wrongCell
            
        case .passwordTextFieldCell:
            let passwordCell =  tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier) as? TextTableViewCell
            let cellConfig = TextTableViewCellConfiguration(type: .password, placeholderText: "inputPassword".localized)
            passwordCell?.configure(with: cellConfig)
            passwordCell?.errorImage.isHidden = isErrorHidden
            let borderColor: UIColor = isErrorHidden ? .black : .red
            passwordCell?.textField.bordered(borderWidth: 1, borderColor: borderColor.cgColor)
            passwordCell?.delegate = self
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
            cell = UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
}

extension LogInViewController: RegisterButtonTableViewCellDelegate {
    
    func didPressLogInButton(_ sender: RegisterButtonTableViewCell) {
        
        guard let emailCell = tableView.cellForRow(at: IndexPath(row: LoginCell.emailTextFieldCell.rawValue, section: 0)) as? TextTableViewCell,
              let passwordCell = tableView.cellForRow(at: IndexPath(row: LoginCell.passwordTextFieldCell.rawValue, section: 0)) as? TextTableViewCell else { return }
        let wrongPasswordCell = tableView.cellForRow(at: IndexPath(row: LoginCell.wrongPasswordEmailCell.rawValue, section: 0)) as? WrongPasswordEmailTableViewCell
        
        emailCell.textField.resignFirstResponder()
        passwordCell.textField.resignFirstResponder()
        
        guard let password = passwordCell.textField.text, let email = emailCell.textField.text else { return }
        
        let isEmailValid = validator.validateEmail(email: email)
        let isPasswordValid = validator.validatePassword(password: password)
        
        if isPasswordValid, isEmailValid {
            startSpinner()
            viewModel?.login(email: email, password: password)
            return
        }
        
        // Error will always be shown if there is some
        isErrorHidden = false
        wrongPasswordCell?.errorLabel.isHidden = false
        wrongPasswordCell?.errorLabel.text = CredentialsError.wrongEmail.getString()
        
        if !isEmailValid {
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            emailCell.errorImage.isHidden = false
        }
        
        if !isPasswordValid {
            passwordCell.errorImage.isHidden = false
            passwordCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
        }
        
    }

}

extension LogInViewController: LinksTableViewCellDelegate {
    func linksTableViewCellDidPressRegister(_ sender: LinksTableViewCell) {
        coordinator?.forgotPasswordScreen(url: AppConstans.urlIntitaRegister)
    }
    
    func linksTableViewCellDidPressForgotPassword(_ sender: LinksTableViewCell) {
        coordinator?.forgotPasswordScreen(url: AppConstans.urlIntitaPasswordRecovery)
    }
}

extension LogInViewController: TextTableViewCellDelegate {
    func textTableViewCellDidBeginEditing(_ sender: TextTableViewCell) {
        guard !isErrorHidden else { return }
        isErrorHidden = true
        
        let wrongPasswordIndexPath = IndexPath(row: LoginCell.wrongPasswordEmailCell.rawValue, section: 0)
        guard let _ = tableView.cellForRow(at: wrongPasswordIndexPath) else { return }
        
        tableView.performBatchUpdates {
            tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        }
    }
}
