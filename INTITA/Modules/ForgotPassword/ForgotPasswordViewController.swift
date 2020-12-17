//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

enum ForgotCells: Int {
    case logoImageCell = 0
    case explanationLabelCell
    case emailTextFieldCell
    case emptyCell
    case sendButtonCell
}

class ForgotPasswordViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ForgotPasswordCoordinator?
    
    var validateEmail = Validate()
    
    @IBOutlet weak var forgotTableView: UITableView!

    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgotTableView.delegate = self
        forgotTableView.dataSource = self
        
        registerCells()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startMonitoringKeyboard()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        stopMonitoringKeyboard()

    }
    
    override func animateKeyboardAppearance(height: CGFloat) {
        
        forgotTableView.beginUpdates()
        tableViewBottomConstraint.constant = height
        view.layoutSubviews()
        forgotTableView.endUpdates()
        
        forgotTableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .bottom, animated: true)
    }
    
    func registerCells() {
        
        let logoCell = UINib(nibName: "LogoTableViewCell", bundle: nil)
        forgotTableView.register(logoCell, forCellReuseIdentifier: "reuseForLogo")
             
        let explanationCell = UINib(nibName: "ExplanationTableViewCell", bundle: nil)
        forgotTableView.register(explanationCell, forCellReuseIdentifier: "ExplanationTableViewCell")
        
        let textCell = UINib(nibName: "TextTableViewCell", bundle: nil)
        forgotTableView.register(textCell, forCellReuseIdentifier: "reuseForText")
        
        
        let registerButtonCell = UINib(nibName: "RegisterButtonTableViewCell", bundle: nil)
        forgotTableView.register(registerButtonCell, forCellReuseIdentifier: "reuseForButton")

    }
    
}

extension ForgotPasswordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let nameCell = ForgotCells(rawValue: indexPath.row)
        var cell: UITableViewCell?
        
        switch nameCell {
        case .logoImageCell:
            guard let logoCell = tableView.dequeueReusableCell(withIdentifier: "reuseForLogo") as? LogoTableViewCell else { return UITableViewCell() }
            logoCell.logoImageView.rounded()
            logoCell.authLabel.text = "passRecovery".localized
            cell = logoCell
            
        case .explanationLabelCell:
            let explanationCell = tableView.dequeueReusableCell(withIdentifier: "ExplanationTableViewCell") as? ExplanationTableViewCell
            cell = explanationCell
            
        case .emailTextFieldCell:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            let cellConfig = TextTableViewCellConfiguration(type: .email, placeholderText: "inputEmail".localized)
            emailCell.configure(with: cellConfig)
            
            cell = emailCell
            
        case .sendButtonCell:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: "reuseForButton") as? RegisterButtonTableViewCell else { return UITableViewCell() }
            buttonCell.delegate = self
            buttonCell.logInButton.setTitle("send".localized, for: .normal)
            cell = buttonCell
            
        default:
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let nameCell = ForgotCells(rawValue: indexPath.row)
        var heightCell: CGFloat
        
        switch nameCell {
        case .logoImageCell:
            heightCell = 243
        case .explanationLabelCell:
            heightCell = 150
        case .emailTextFieldCell, .sendButtonCell:
            heightCell = 77
        default:
            heightCell = 20
        }
        
        return heightCell
    }
}

extension ForgotPasswordViewController: RegisterButtonTableViewCellDelegate, AlertAcceptable {
    
    func didPressLogInButton(_ sender: RegisterButtonTableViewCell) {
        
        guard let emailCell = forgotTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TextTableViewCell else { return }
        
        guard let email = emailCell.textField.text else { return }
        
        if (!validateEmail.validateEmail(email: email)) && (email != "") {
            
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
         
        } else if email == "" {
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.emailIsEmpty.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else {
            
            showAlert(header: "passRecovery".localized)
        }
    }
    
}
