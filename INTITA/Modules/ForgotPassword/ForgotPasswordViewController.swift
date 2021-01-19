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
    
    var coordinator: ForgotPasswordCoordinator?
    
    var validateEmail = Validate()
    
    @IBOutlet weak var forgotTableView: UITableView!

    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgotTableView.delegate = self
        forgotTableView.dataSource = self
        
        registerCells()
        
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
        forgotTableView.register(LogoTableViewCell.nib(), forCellReuseIdentifier: LogoTableViewCell.identifier)
             
        forgotTableView.register(ExplanationTableViewCell.nib(), forCellReuseIdentifier: ExplanationTableViewCell.identifier)
        
        forgotTableView.register(TextTableViewCell.nib(), forCellReuseIdentifier: TextTableViewCell.identifier)
        
        forgotTableView.register(RegisterButtonTableViewCell.nib(), forCellReuseIdentifier: RegisterButtonTableViewCell.identifier)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    
        coordinator?.returnToLoginScreen()
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
            let logoCell = tableView.dequeueReusableCell(withIdentifier: LogoTableViewCell.identifier) as? LogoTableViewCell
            logoCell?.logoImageView.rounded()
            logoCell?.authLabel.text = "passRecovery".localized
            cell = logoCell
            
        case .explanationLabelCell:
            let explanationCell = tableView.dequeueReusableCell(withIdentifier: ExplanationTableViewCell.identifier) as? ExplanationTableViewCell
            cell = explanationCell
            
        case .emailTextFieldCell:
            let emailCell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier) as? TextTableViewCell
            let cellConfig = TextTableViewCellConfiguration(type: .email, placeholderText: "inputEmail".localized)
            emailCell?.configure(with: cellConfig)
            
            cell = emailCell
            
        case .sendButtonCell:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: RegisterButtonTableViewCell.identifier) as? RegisterButtonTableViewCell
            buttonCell?.delegate = self
            buttonCell?.logInButton.setTitle("send".localized, for: .normal)
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
        
        if !validateEmail.validateEmail(email: email) {
            
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
         
        } else {
            
            showAlert(header: "passRecovery".localized)
        }
    }
    
}
