//
//  TextTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 13.11.2020.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var eyeButtonTrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    var configuration: TextTableViewCellConfiguration?

    @IBAction func eyeButtonPressed(_ sender: UIButton) {
        if eyeButton.image(for: .normal) == UIImage(systemName: "eye") {
            textField.isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            textField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @IBAction func didBeginEditing(_ sender: UITextField) {
        setupUI()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
        textField.indent(size: 10)
        textField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setupUI()
    }
    
    func setupUI() {
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.delegate = self
        errorImage.isHidden = true
        errorLabel.isHidden = true
        eyeButton.alpha = 0.5
        eyeButtonTrailingContraint.constant = 32
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded(cornerRadius: 10.0)
    }
    
    func configure(with configuration: TextTableViewCellConfiguration) {
        self.configuration = configuration
        textField.placeholder = configuration.placeholderText
        textField.textContentType = configuration.type.textContentType
        textField.isSecureTextEntry = configuration.type.isSecureTextEntry
    }
}

extension TextTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let configuration = configuration, configuration.type == .password else { return }
        eyeButton.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let configuration = configuration, configuration.type == .password else { return }
        eyeButton.isHidden = true
    }
}
