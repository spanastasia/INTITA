//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

class ForgotPasswordViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ForgotPasswordCoordinator?
    
    var validateEmail = Validate()
    
    let spacingBetweenCells: CGFloat = 40
    var heightTableView: CGFloat = 540
    
    @IBOutlet weak var forgotTableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
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
        
        let heightView = UIScreen.main.bounds.height
        let differentHeight = heightView - heightTableView
        
        var resultHeightConstreint: CGFloat
        
        if (heightTableView - differentHeight) > height {
            resultHeightConstreint = -height - (spacingBetweenCells / 2)
        } else {
            resultHeightConstreint = differentHeight - heightTableView
        }

        forgotTableView.beginUpdates()
        tableViewTopConstraint.constant = resultHeightConstreint
        view.layoutSubviews()
        forgotTableView.endUpdates()
        
    }
    
    func registerCells() {
        let logoCell = UINib(nibName: "LogoForgotTableViewCell", bundle: nil)
        forgotTableView.register(logoCell, forCellReuseIdentifier: "LogoForgotTableViewCell")
        
        let passCell = UINib(nibName: "PassRecoveryTableViewCell", bundle: nil)
        forgotTableView.register(passCell, forCellReuseIdentifier: "PassRecoveryTableViewCell")
        
        let textCell = UINib(nibName: "ExplanationTableViewCell", bundle: nil)
        forgotTableView.register(textCell, forCellReuseIdentifier: "ExplanationTableViewCell")
        
        let emailCell = UINib(nibName: "EmailTableViewCell", bundle: nil)
        forgotTableView.register(emailCell, forCellReuseIdentifier: "EmailTableViewCell")
        
        let registerButtonCell = UINib(nibName: "SendButtonTableViewCell", bundle: nil)
        forgotTableView.register(registerButtonCell, forCellReuseIdentifier: "SendButtonTableViewCell")
    }
    
}

extension ForgotPasswordViewController: UITableViewDelegate {
        
    }

extension ForgotPasswordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 1:
            guard let logoCell = tableView.dequeueReusableCell(withIdentifier: "LogoForgotTableViewCell") as? LogoForgotTableViewCell else { return UITableViewCell() }
            return logoCell
        case 3:
            guard let passRecoveryCell = tableView.dequeueReusableCell(withIdentifier: "PassRecoveryTableViewCell") as? PassRecoveryTableViewCell else { return UITableViewCell() }
            return passRecoveryCell
        case 5:
            guard let explanationCell = tableView.dequeueReusableCell(withIdentifier: "ExplanationTableViewCell") as? ExplanationTableViewCell else { return UITableViewCell() }
            return explanationCell
        case 6:
            guard let emailCell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell") as? EmailTableViewCell else { return UITableViewCell() }
            emailCell.textField.placeholder = "inputEmail".localized
            emailCell.textField.textContentType = .emailAddress
            return emailCell
        case 8:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: "SendButtonTableViewCell") as? SendButtonTableViewCell else { return UITableViewCell() }
            buttonCell.delegate = self
            return buttonCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return spacingBetweenCells / 2
        case 1:
            return view.frame.width * 0.244
        case 3:
            return view.frame.width * 0.16
        case 5:
            return view.frame.width * 0.304
        case 6:
            return view.frame.width * 0.2
        case 8:
            return view.frame.width * 0.147
        default:
            return spacingBetweenCells
        }
    }
}

extension ForgotPasswordViewController: SendButtonTableViewCellDelegate {
    
    func didPressSendButton(_ sender: SendButtonTableViewCell) {
        
        guard let emailCell = forgotTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? EmailTableViewCell else { return }
        
        emailCell.textField.resignFirstResponder()

        guard let email = emailCell.textField.text else { return }
        
        if !validateEmail.validateEmail(email: email) {
            emailCell.wrongLabel.isHidden = false
            emailCell.wrongLabel.text = CredentialsError.wrongEmail.getString()
            emailCell.textField.bordered(borderWidth: 1, borderColor: UIColor.red.cgColor)
        } else {
            startSpinner()
        }
    }
    
}
