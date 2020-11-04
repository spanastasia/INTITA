//
//  LogInViewController.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import UIKit
import SafariServices

enum CredentialsError {
    case passwordIsEmpty
    case emailIsEmpty
    case wrongEmail
    
    func getString() -> String {
        switch self {
        case .passwordIsEmpty:
            return "inputPassword".localized
        case .emailIsEmpty:
            return "inputEmail".localized
        case .wrongEmail:
            return "wrongEmail".localized
        }
    }
}

class LogInViewController: UIViewController, Storyboarded {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    weak var coordinator: LogInCoordinator?

    //MARK:- Actions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        showSafari("https://intita.com/register")
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        errorLabel.isHidden = true
        guard let password = passwordTextField.text, let email = emailTextField.text else {
            return
        }
        validateCredentials(password, email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        registerButton.setTitle("register".localized, for: .normal)
        forgotPasswordButton.setTitle("forgotPass".localized, for: .normal)
        logInButton.setTitle("logIn".localized, for: .normal)
        
        passwordTextField.placeholder = "inputPassword".localized
        emailTextField.placeholder = "inputEmail".localized
    }
    
    private func validateCredentials(_ password: String, _ email: String) {
        if password.isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.passwordIsEmpty.getString()
        } else if email.isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.emailIsEmpty.getString()
        }
        guard email.contains("@") else {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.wrongEmail.getString()
            return
        }
        if email.components(separatedBy: "@")[1].isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.wrongEmail.getString()
        }
    }
    
    private func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
