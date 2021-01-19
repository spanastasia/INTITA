//
//  InfoSettingProfileTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

class InfoSettingProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var aboutSelfLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    var isProfileEditing = false {
        didSet {
            if isProfileEditing {
                setupTextField()
            } else {
                hideTextField()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
    }
        
    private func setupTextField() {
        
        infoTextField.isHidden = false
        infoTextField.rounded(cornerRadius: 1, roundOnlyBottomCorners: true)
    }
    
    func hideTextField() {
        
        infoTextField.isHidden = true
        infoTextField.rounded(cornerRadius: 0, roundOnlyBottomCorners: true)
    }
    
}

extension InfoSettingProfileTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.becomeFirstResponder()
        print("you taper textfild")
        return true
    }
}
