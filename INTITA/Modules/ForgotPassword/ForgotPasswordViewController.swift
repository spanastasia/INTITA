//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

enum NameCells: Int {
    case logoImageCell = 0
    case passwordRecoveryCell
    case explanationLabelCell
    case emailTextFieldCell
    case sendButtonCell
}

class ForgotPasswordViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ForgotPasswordCoordinator?
    
    var validateEmail = Validate()
    
    let heightOfView = UIScreen.main.bounds.height
    let koefWidth = UIScreen.main.bounds.width / 375
    
    @IBOutlet weak var forgotTableView: UITableView!

    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgotTableView.delegate = self
        forgotTableView.dataSource = self
        
        registerCells()
        
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
        
        forgotTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: true)
    }
    
    func registerCells() {
        
        let logoCell = UINib(nibName: "LogoForgotTableViewCell", bundle: nil)
        forgotTableView.register(logoCell, forCellReuseIdentifier: "LogoForgotTableViewCell")
        
        let passCell = UINib(nibName: "PassRecoveryTableViewCell", bundle: nil)
        forgotTableView.register(passCell, forCellReuseIdentifier: "PassRecoveryTableViewCell")
        
        let explanationCell = UINib(nibName: "ExplanationTableViewCell", bundle: nil)
        forgotTableView.register(explanationCell, forCellReuseIdentifier: "ExplanationTableViewCell")
        
        let textCell = UINib(nibName: "TextTableViewCell", bundle: nil)
        forgotTableView.register(textCell, forCellReuseIdentifier: "reuseForText")
        
        let sendButtonCell = UINib(nibName: "SendButtonTableViewCell", bundle: nil)
        forgotTableView.register(sendButtonCell, forCellReuseIdentifier: "SendButtonTableViewCell")
    }
    
}

extension ForgotPasswordViewController: UITableViewDelegate {
        
    }

extension ForgotPasswordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell: UITableViewCell?
        
        switch indexPath.row {
        case 0:
            let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoForgotTableViewCell") as? LogoForgotTableViewCell
            cell = logoCell
        case 1:
            let passRecoveryCell = tableView.dequeueReusableCell(withIdentifier: "PassRecoveryTableViewCell") as? PassRecoveryTableViewCell
            cell = passRecoveryCell
        case 2:
            let explanationCell = tableView.dequeueReusableCell(withIdentifier: "ExplanationTableViewCell") as? ExplanationTableViewCell
            cell = explanationCell
        case 3:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            let cellModel = TextTableViewCellModel(type: .email, placeholderText: "inputEmail".localized)
            emailCell.configure(with: cellModel)
            
            cell = emailCell
        case 4:
            let sendButtonCell = tableView.dequeueReusableCell(withIdentifier: "SendButtonTableViewCell") as? SendButtonTableViewCell
            sendButtonCell?.delegate = self
            cell = sendButtonCell
        default:
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var heightCell: CGFloat
        
        switch NameCells.init(rawValue: indexPath.item) {
        case .logoImageCell:
            heightCell = 148 * koefWidth
        case .passwordRecoveryCell:
            heightCell = 95 * koefWidth
        case .explanationLabelCell:
            heightCell = 114
        case .sendButtonCell:
            heightCell = 77
        case .emailTextFieldCell:
            heightCell = 93
        default:
            heightCell = 0
        }
        
        return heightCell
    }
}

extension ForgotPasswordViewController: SendButtonTableViewCellDelegate, AlertAcceptable {
    
    func didPressSendButton(_ sender: SendButtonTableViewCell) {
        
        guard let emailCell = forgotTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TextTableViewCell else { return }
        
        guard let email = emailCell.textField.text else { return }
        
        if !validateEmail.validateEmail(email: email) {
            
            emailCell.errorLabel.isHidden = false
            emailCell.errorImage.isHidden = false
            emailCell.errorLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
            
        } else {
            
            showAlert(header: "passRecovery".localized)
//            startSpinner()
        }
    }
    
}
