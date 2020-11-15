//
//  TextTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 12.11.2020.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    func setupUI() {
        errorlabel.isHidden = true
        errorImage.isHidden = true
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded(cornerRadius: 5.0)
    }
    
    @objc func textFieldDidChanged() {
        setupUI()
    }
}
