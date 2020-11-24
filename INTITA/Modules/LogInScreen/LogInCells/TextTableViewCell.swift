//
//  TextTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 13.11.2020.
//

import UIKit

protocol TextTableViewCellDelegate: AnyObject {
    func didPressEyeButton(_ sender: TextTableViewCell)
}

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var eyeButtonTrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    
    weak var delegate: TextTableViewCellDelegate?
    
    @IBAction func eyeButtonPressed(_ sender: UIButton) {
        delegate?.didPressEyeButton(self)
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
        errorImage.isHidden = true
        errorLabel.isHidden = true
        eyeButtonTrailingContraint.constant = 32
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded(cornerRadius: 10.0)
    }
}
