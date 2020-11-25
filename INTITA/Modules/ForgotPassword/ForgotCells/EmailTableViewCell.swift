//
//  EmailTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 23.11.2020.
//

import UIKit

class EmailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
        textField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        setupTextField()
    }
    
    func setupTextField() {

        wrongLabel.isHidden = true
        textField.bordered(borderWidth: 1.0, borderColor: UIColor.black.cgColor)
        textField.rounded()
    }
  
}
