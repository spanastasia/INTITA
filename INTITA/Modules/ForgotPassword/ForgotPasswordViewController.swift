//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

enum NameCells: Int {
    case logoImageCell = 0
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
        
        let sendButtonCell = UINib(nibName: "SendButtonTableViewCell", bundle: nil)
        forgotTableView.register(sendButtonCell, forCellReuseIdentifier: "SendButtonTableViewCell")
    }
    
}

extension ForgotPasswordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell: UITableViewCell?
        
        switch indexPath.row {
        case 0:
            guard let logoCell = tableView.dequeueReusableCell(withIdentifier: "reuseForLogo") as? LogoTableViewCell else { return UITableViewCell() }
            logoCell.logoImageView.rounded()
            logoCell.authLabel.text = "passRecovery".localized
            cell = logoCell
        case 1:
            let explanationCell = tableView.dequeueReusableCell(withIdentifier: "ExplanationTableViewCell") as? ExplanationTableViewCell
            cell = explanationCell
        case 2:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "reuseForText") as? TextTableViewCell else { return UITableViewCell() }
            let cellConfig = TextTableViewCellConfiguration(type: .email, placeholderText: "inputEmail".localized)
            emailCell.configure(with: cellConfig)
            
            cell = emailCell
        case 3:
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
            heightCell = 243 * koefWidth
        case .explanationLabelCell:
            heightCell = 114
        case .sendButtonCell:
            heightCell = 77
        case .emailTextFieldCell:
            heightCell = 77
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
        }
    }
    
}
