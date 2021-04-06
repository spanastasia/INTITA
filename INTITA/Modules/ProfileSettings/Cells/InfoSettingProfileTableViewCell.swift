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
        infoTextField.placeholder = "tap to edit"
    }
        
    private func setupTextField(with value: String = "") {
        
        updateContent()
        
        switch type {
        case .textField:
            infoTextField.text = value
        default:
            countryButton.setTitle(value, for: .normal)
        }
    }
    
    func updateContent() {
        rightButton.isHidden = type.isArrowHidden(isEditing: isProfileEditing)
        countryButton.isHidden = type.isSelectHidden(isEditing: isProfileEditing)
        infoTextField.isHidden = type.isInputHidden(isEditing: isProfileEditing)
        
        if isProfileEditing {
            infoTextField.font = UIFont(name: "MyriadPro-Light", size: 16)
            countryButton.titleLabel?.font = UIFont(name: "MyriadPro-Light", size: 16)
        } else {
            infoTextField.font = .boldSystemFont(ofSize: 14)
            countryButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }
        
        isUserInteractionEnabled = isProfileEditing
    }
    
    func configure(withTitle: String, value: String?, isEditing: Bool, indexPath: Int) {
        
        setupTextField(with: value ?? "tap to edit")
        
        if indexPath.isMultiple(of: 2) {
            cellView.backgroundColor = .white
        } else {
            cellView.backgroundColor = .systemGray6
        }
        isProfileEditing = isEditing
        titleLabel.text = withTitle
        
    }
    
    func configureIsEnabled(withTitle: String, value: String?, isEditing: Bool, indexPath: Int) {
        
        setupTextField(with: value ?? "tap to edit")
        
        if indexPath.isMultiple(of: 2) {
            cellView.backgroundColor = .white
        } else {
            cellView.backgroundColor = .systemGray6
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
