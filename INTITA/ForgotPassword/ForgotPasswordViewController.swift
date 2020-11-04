//
//  ForgotPasswordViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

class ForgotPasswordViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ForgotPasswordCoordinator?
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var blueLineView: UIView!
    
    @IBOutlet weak var recoveryLabel: UILabel!
    @IBOutlet weak var explanationTextLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var invalidTxtLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recoveryLabel.text = "passRecovery".localized
        self.explanationTextLabel.text = "textRecovery".localized
        
        setupInvalidTxtLabel()
        setupEmailTextField()
        setupSendButton()

        emailTextField.delegate = self
        
    }
    
    func setupInvalidTxtLabel() {
        
        let title = ""
        self.invalidTxtLabel.text = title
        self.invalidTxtLabel.textColor = .red

    }
    
    func setupEmailTextField() {

        self.emailTextField.layer.cornerRadius = 4
        self.emailTextField.borderStyle = .line
        self.emailTextField.keyboardAppearance = .dark
        self.emailTextField.backgroundColor = .white
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.placeholder = "Enter your Email"
        self.emailTextField.clearButtonMode = .whileEditing
        
    }
    
    func setupSendButton() {
        
        let titleLocalized = "send".localized
        self.sendButton.layer.cornerRadius = 8
        self.sendButton.setTitle(titleLocalized, for: .normal)
        
    }
    
    @IBAction func pressedSendButton(_ sender: UIButton) {
        
        guard let textEmail = self.emailTextField.text else { return }
        
        if textEmail == "" {
            self.invalidTxtLabel.attributedText = NSAttributedString(string: "You don't entered Email", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        } else if textEmail.count <= 6 {
            self.invalidTxtLabel.attributedText = NSAttributedString(string: "You entered too small Email", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            emailTextField.text = ""
        } else if (!textEmail.contains("@") && !textEmail.contains(".")) {
            self.invalidTxtLabel.attributedText = NSAttributedString(string: "You entered Email without . or @", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            emailTextField.text = ""
        } else {
            invalidTxtLabel.text = ""
        }
    }
    
}

extension ForgotPasswordViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //For symbol
        if textField == emailTextField {
            //Here change this characters based on your requirement
            let allowedCharacters = CharacterSet(charactersIn:".@_-0123456789ABCDFGHJKLMNPQRSTVWXZabcdfg hjklmnpqrstvwxz")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }

        return true
    }
    
}
