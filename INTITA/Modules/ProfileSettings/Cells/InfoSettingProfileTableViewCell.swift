//
//  InfoSettingProfileTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

enum SettingProfileCell {
    case button
    case textField
    
    func isArrowHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button:
            return isEditing == false
        case .textField:
            return true
        }
    }
    
    func isSelectHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button:
            return false
        case .textField:
            return true
        }
    }
    
    func isInputHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button:
            return true
        case .textField:
            return false
        }
    }
    
}

class InfoSettingProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var type: SettingProfileCell = .textField
    var isProfileEditing = false {
        didSet {
            updateContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
    }
        
    private func setupTextField() {
        
        updateContent()
        
        switch type {
        case .textField:
            infoTextField.placeholder = "some text"
        default:
            countryButton.setTitle("country".localized, for: .normal)
        }
    }
    
    func updateContent() {
        rightButton.isHidden = type.isArrowHidden(isEditing: isProfileEditing)
        countryButton.isHidden = type.isSelectHidden(isEditing: isProfileEditing)
        infoTextField.isHidden = type.isInputHidden(isEditing: isProfileEditing)
        
        isUserInteractionEnabled = isProfileEditing
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
