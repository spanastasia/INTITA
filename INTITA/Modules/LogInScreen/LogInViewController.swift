//
//  LogInViewController.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import UIKit
import SafariServices

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

class LogInViewController: UIViewController, Storyboarded {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    weak var coordinator: LogInCoordinator?
    var viewModel: LogInViewModel?
    let validator = Validate()
    let alert = AlertView().fromNib()

    //MARK:- Actions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        showSafari("https://intita.com/register")
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        errorLabel.isHidden = true
        guard let password = passwordTextField.text, let email = emailTextField.text else {
            return
        }
        if !validator.validateEmail(email: email) {
            errorLabel.isHidden = false
            
            errorLabel.text = CredentialsError.wrongEmail.getString()
        } else if !validator.validatePassword(password: password) {
            errorLabel.isHidden = false
            errorLabel.text = CredentialsError.wrongPassword.getString()
        } else {
            viewModel?.login(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alert)
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
            DispatchQueue.main.async {
                self.alert.customizeAndShow(message: error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        registerButton.setTitle("register".localized, for: .normal)
        forgotPasswordButton.setTitle("forgotPass".localized, for: .normal)
        logInButton.setTitle("logIn".localized, for: .normal)
        logInButton.rounded(cornerRadius: 10.0)
        //text fields
        passwordTextField.placeholder = "inputPassword".localized
        passwordTextField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        passwordTextField.rounded(cornerRadius: 5.0)
        
        emailTextField.placeholder = "inputEmail".localized
        emailTextField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        emailTextField.rounded(cornerRadius: 5.0)
    }
    
    private func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
