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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    weak var coordinator: LogInCoordinator?
    var viewModel: LogInViewModel?

    //MARK:- Actions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        showSafari("https://intita.com/register")
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        errorLabel.isHidden = true
        guard let password = passwordTextField.text, let email = emailTextField.text else {
            return
        }
        if validateCredentials(password, email) {
            viewModel?.login(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel?.subscribe(updateCallback: handleViewModelUpdateWith)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
    
    func handleViewModelUpdateWith(error: Error?) {
        if let error = error {
            print("ERRORORROOR \(error)")
            return
        }
    }
    
    private func setupUI() {
        registerButton.setTitle("register".localized, for: .normal)
        forgotPasswordButton.setTitle("forgotPass".localized, for: .normal)
        logInButton.setTitle("logIn".localized, for: .normal)
        logInButton.layer.cornerRadius = 10.0
        
        //text fields
        passwordTextField.placeholder = "inputPassword".localized
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 5.0
        emailTextField.placeholder = "inputEmail".localized
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 5.0
        
        
    }
    
    private func validateCredentials(_ password: String, _ email: String) -> Bool {
        var result = true
        if password.isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.passwordIsEmpty.getString()
            result = false
        } else if email.isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.emailIsEmpty.getString()
            result = false
        }
        guard email.contains("@") else {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.wrongEmail.getString()
            return false
        }
        if email.components(separatedBy: "@")[1].isEmpty {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.wrongEmail.getString()
            result = false
        }
        return result
    }
    
    private func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
