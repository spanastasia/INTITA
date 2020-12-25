//
//  InfoSettingProfileTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

class InfoSettingProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutSelfLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    static let identifire = "InfoSettingProfileTableViewCell"
    
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
    
    static func nib() -> UINib {
        return UINib(nibName: identifire, bundle: nil)
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
