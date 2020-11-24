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
    var model: TextTableViewCellModel?

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
        textField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setupUI()
    }
    
    func setupUI() {
        textField.delegate = self
        errorImage.isHidden = true
        errorLabel.isHidden = true
        eyeButtonTrailingContraint.constant = 32
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded(cornerRadius: 10.0)
    }
    
    func configure(with model: TextTableViewCellModel) {
        self.model = model
        textField.placeholder = model.placeholderText
        textField.textContentType = model.type.textContentType
        textField.isSecureTextEntry = model.type.isSecureTextEntry
    }
}

extension TextTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let model = model, model.type == .password else { return }
        eyeButton.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let model = model, model.type == .password else { return }
        eyeButton.isHidden = true
    }
}
