//
//  InfoSettingProfileTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

class InfoSettingProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    var isProfileEditing = false {
        didSet {
            isProfileEditing ? setupTextField() : hideTextField()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
    }
        
    private func setupTextField() {
        rightButton.isHidden = false
        infoTextField.isHidden = false
        infoTextField.rounded(cornerRadius: 1, roundOnlyBottomCorners: true)
    }
    
    func hideTextField() {
        rightButton.isHidden = true
        infoTextField.isHidden = true
        infoTextField.rounded(cornerRadius: 0, roundOnlyBottomCorners: true)
    }
    
    func configure(withTitle: String, isEditing: Bool, indexPath: Int) {
        
        if indexPath.isMultiple(of: 2) {
            cellView.backgroundColor = .systemGray6
        } else {
            cellView.backgroundColor = .white
        }
        
        isProfileEditing = isEditing
        titleLabel.text = withTitle
    }
    
}

extension InfoSettingProfileTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.becomeFirstResponder()
        print("you taper textfild")
        return true
    }
}
