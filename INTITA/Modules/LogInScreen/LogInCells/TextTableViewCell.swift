//
//  TextTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 13.11.2020.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    
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
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded(cornerRadius: 10.0)
    }
}
