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
    case menu
}

class InfoSettingProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var type: SettingProfileCell = .textField
    var isProfileEditing = false {
        didSet {
            isProfileEditing ? setupTextField() : hideTextField()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setupTextField()
    }
        
    private func setupTextField() {
        
        switch type {
        case .textField:
            infoTextField.rounded(cornerRadius: 1, roundOnlyBottomCorners: true)
            infoTextField.placeholder = "some text"
            infoTextField.isHidden = false
            rightButton.isHidden = true
            countryButton.isHidden = true
        default:
            rightButton.isHidden = false
            countryButton.isHidden = false
            countryButton.setTitle("country".localized, for: .normal)
            stackView.bordered(borderWidth: 1, borderColor: UIColor.systemGray5.cgColor)
            stackView.rounded(cornerRadius: 5, roundOnlyBottomCorners: false)
            infoTextField.isHidden = true
        }
    }
    
    func hideTextField() {
        rightButton.isHidden = true
        countryButton.isHidden = true
        infoTextField.isHidden = true
        stackView.bordered(borderWidth: 0)
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
