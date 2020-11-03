//
//  InvalidViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

class InvalidViewController: UIViewController, Storyboarded {
    
    weak var coordinator: InvalidCoordinator?
    
    lazy private var motoLabel = { return UILabel() }()
    lazy private var infoLabel = { return UILabel() }()
    
    lazy private var invalidEmailTextField = { return UITextField() }()
    lazy private var invalidEmailTextLabel = { return UILabel() }()
    
    lazy private var doneButton = { return UIButton() }()
    
    private let spasing: CGFloat = 8
    private let widthOfScreen: CGFloat = UIScreen.main.bounds.width
    private let hightOfFields: CGFloat = 48

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMoto()
        view.addSubview(motoLabel)
        setupConstraintMoto()
        
        setupInfo()
        view.addSubview(infoLabel)
        setupConstraintInfo()
        
        setupInvalidEmailTextField()
        view.addSubview(invalidEmailTextField)
        setupConstraintEmail()
        
        setupInvalidEmailTextLabel()
        view.addSubview(invalidEmailTextLabel)
        setupConstraintEmailTextLabel()
        
        setupDoneButton()
        view.addSubview(doneButton)
        setupConstraintButton()
        
        invalidEmailTextField.delegate = self
        
    }
    
    func setupMoto() {

        self.motoLabel.textAlignment = .center
        self.motoLabel.textColor = .systemBlue
        self.motoLabel.font = UIFont.systemFont(ofSize: 32)
        self.motoLabel.text = "moto".localized
    }
    
    func setupConstraintMoto() {
        self.motoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.motoLabel.widthAnchor.constraint(equalToConstant: (self.widthOfScreen - 2 * self.spasing)).isActive = true
        self.motoLabel.heightAnchor.constraint(equalToConstant: self.hightOfFields).isActive = true
        self.motoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.motoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: self.hightOfFields * 2).isActive = true
    }
    
    func setupInfo() {

        self.infoLabel.textAlignment = .center
        self.infoLabel.textColor = .gray
        self.infoLabel.textAlignment = .justified
        self.infoLabel.numberOfLines = 0
        self.infoLabel.lineBreakMode = .byWordWrapping
        self.infoLabel.font = UIFont.systemFont(ofSize: 20)
        self.infoLabel.text = """
To reset your password, enter your email below. In this e-mail the link to reset your password will be sent. The link is active for 30 min.
"""

    }
    
    func setupConstraintInfo() {
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.widthAnchor.constraint(equalToConstant: (self.widthOfScreen - 2 * self.spasing)).isActive = true
        self.infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.infoLabel.topAnchor.constraint(equalTo: motoLabel.topAnchor, constant: self.hightOfFields).isActive = true
    }
    
    func setupInvalidEmailTextField() {

        self.invalidEmailTextField.borderStyle = .line
        self.invalidEmailTextField.keyboardAppearance = .dark
        self.invalidEmailTextField.backgroundColor = .white
        self.invalidEmailTextField.keyboardType = .emailAddress
        self.invalidEmailTextField.placeholder = "Enter your Email"
        self.invalidEmailTextField.font = UIFont.systemFont(ofSize: 20)
        self.invalidEmailTextField.clearButtonMode = .whileEditing
        
    }
    
    func setupConstraintEmail() {
        self.invalidEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.invalidEmailTextField.widthAnchor.constraint(equalToConstant: (self.widthOfScreen - 2 * self.spasing)).isActive = true
        self.invalidEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.invalidEmailTextField.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: self.hightOfFields * 3).isActive = true
    }
    
    func setupInvalidEmailTextLabel() {
        
        let title = "you entered wrong Email"
        
        self.invalidEmailTextLabel.isHidden = true
        self.invalidEmailTextLabel.attributedText = NSAttributedString(string: title, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        self.invalidEmailTextLabel.textColor = .red
        self.invalidEmailTextLabel.text = title
        self.invalidEmailTextLabel.font = UIFont.systemFont(ofSize: 15)
        
    }
    
    func setupConstraintEmailTextLabel() {
        
        self.invalidEmailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.invalidEmailTextLabel.widthAnchor.constraint(equalToConstant: (self.widthOfScreen - 2 * self.spasing)).isActive = true
        self.invalidEmailTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.invalidEmailTextLabel.topAnchor.constraint(equalTo: invalidEmailTextField.topAnchor, constant: self.hightOfFields - self.spasing).isActive = true
    }
    
    func setupDoneButton() {

        self.doneButton.setTitle( "Done", for: .normal)
        self.doneButton.setTitleColor(.white, for: .normal)
        self.doneButton.backgroundColor = .systemBlue
        self.doneButton.layer.cornerRadius = 4
        self.doneButton.isHighlighted = true
        self.doneButton.isUserInteractionEnabled = true
        
        self.doneButton.addTarget(self, action: #selector(PressedDoneButton), for: .touchUpInside)
    }
    
    func setupConstraintButton() {
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.doneButton.widthAnchor.constraint(equalToConstant: self.widthOfScreen / 2 ).isActive = true
        self.doneButton.heightAnchor.constraint(equalToConstant: self.hightOfFields).isActive = true
        self.doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.doneButton.topAnchor.constraint(equalTo: invalidEmailTextLabel.topAnchor, constant: self.hightOfFields * 2).isActive = true
    }
    
    @objc func PressedDoneButton(sender: UIButton) {
        
        availableEmail()

    }

    func availableEmail() {
        
        guard let textEmail = self.invalidEmailTextField.text else { return }
        
        if textEmail == "" {
            self.invalidEmailTextLabel.isHidden = false
            self.invalidEmailTextLabel.text = "You don't entered Email"
        } else if textEmail.count <= 10 {
            self.invalidEmailTextLabel.isHidden = false
            self.invalidEmailTextLabel.text = "You entered too small Email"
            invalidEmailTextField.text = ""
        } else if (!textEmail.contains("@") && !textEmail.contains(".")) {
            self.invalidEmailTextLabel.isHidden = false
            self.invalidEmailTextLabel.text = "You entered Email without . or @"
            invalidEmailTextField.text = ""
        } else {
            self.invalidEmailTextLabel.isHidden = true
        }
    }
    
}

extension InvalidViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //For symbol
        if textField == invalidEmailTextField {
            //Here change this characters based on your requirement
            let allowedCharacters = CharacterSet(charactersIn:".@_-0123456789ABCDFGHJKLMNPQRSTVWXZabcdfg hjklmnpqrstvwxz")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
    
}


