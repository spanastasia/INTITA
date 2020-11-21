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
    
//    @IBOutlet weak var logoImageView: UIImageView!
//
//    @IBOutlet weak var blueLineView: UIView!
//
//    @IBOutlet weak var recoveryLabel: UILabel!
//    @IBOutlet weak var explanationTextLabel: UILabel!
//
//    @IBOutlet weak var emailTextField: UITextField!
//
//    @IBOutlet weak var invalidTextLabel: UILabel!
//    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.recoveryLabel.text = "passRecovery".localized
//        self.explanationTextLabel.text = "textRecovery".localized
//
//        setupInvalidTextLabel()
//        setupEmailTextField()
//        setupSendButton()
        
    }
    
//    func setupInvalidTextLabel() {
//
//        let title = ""
//        invalidTextLabel.text = title
//        invalidTextLabel.textColor = .red
//
//    }
    
//    func setupEmailTextField() {
//
//        emailTextField.layer.cornerRadius = 4
//        emailTextField.borderStyle = .line
//        emailTextField.keyboardAppearance = .dark
//        emailTextField.backgroundColor = .white
//        emailTextField.keyboardType = .emailAddress
//        emailTextField.placeholder = "Enter your Email"
//        emailTextField.clearButtonMode = .whileEditing
//
//    }
    
//    func setupSendButton() {
//
//        let titleLocalized = "send".localized
//        sendButton.layer.cornerRadius = 8
//        sendButton.setTitle(titleLocalized, for: .normal)
//
//    }
    
//    @IBAction func pressedSendButton(_ sender: UIButton) {
//        
//        guard let textEmail = self.emailTextField.text else { return }
//        
//        if !validateEmail.validateEmail(email: textEmail) {
//            invalidTextLabel.isHidden = false
//            invalidTextLabel.text = "You entered wrong Email"
//        } else {
//            invalidTextLabel.text = "Your Email sent"
//        }
//    }
    
}
