//
//  InfoSettingProfileTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

enum LinkCell {
    case link
    case text
    
    func isLinkEnable(isEditing: Bool) -> Bool {
        switch self {
        case .link:
            return true
        case .text:
            return false
        }
    }
}

enum SettingProfileCell {
    case button
    case textField
    case textView
    
    func isArrowHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button:
            return isEditing == false
        case .textField, .textView:
            return true
        }
    }
    
    func isSelectHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button:
            return false
        case .textField, .textView:
            return true
        }
    }
    
    func isInputHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button, .textView:
            return true
        case .textField:
            return false
        }
    }
    
    func isStackViewHidden(isEditing: Bool) -> Bool {
        switch self {
        case .button, .textField:
            return true
        case .textView:
            return false
        }
    }
    
}

protocol InfoSettingProfileTableViewCellDelegate: AnyObject {
    func didTapedTextField(_ sender: InfoSettingProfileTableViewCell, tapedText: String?)
}

class InfoSettingProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var editingTextView: UITextView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editingStackView: UIStackView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var usualStackView: UIStackView!
    
    weak var delegate: InfoSettingProfileTableViewCellDelegate?
    
    var indexCell: Int?
    var enableType: LinkCell = .text
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
    
    @objc func editingChanged(_ textField: UITextField) {
        delegate?.didTapedTextField(self, tapedText: textField.text)
    }
        
    private func setupTextField(with value: String = "") {
        
        updateContent()
        valueLabel.text = value
        
        switch type {
        case .textField:
            infoTextField.text = value
        case .textView:
            editingTextView.text = value
        default:
            countryButton.setTitle(value, for: .normal)
        }
    }
    
    func updateContent() {
        
        if isProfileEditing {
            usualStackView.isHidden = true
            editingStackView.isHidden = false
            isUserInteractionEnabled = isProfileEditing
        } else {
            usualStackView.isHidden = false
            editingStackView.isHidden = true
            isUserInteractionEnabled = enableType.isLinkEnable(isEditing: isProfileEditing)
        }
        
        editingTextView.isHidden = type.isStackViewHidden(isEditing: isProfileEditing)
        rightButton.isHidden = type.isArrowHidden(isEditing: isProfileEditing)
        countryButton.isHidden = type.isSelectHidden(isEditing: isProfileEditing)
        infoTextField.isHidden = type.isInputHidden(isEditing: isProfileEditing)
       
//        if isProfileEditing {
//            infoTextField.font = UIFont(name: "MyriadPro-Light", size: 16)
//            countryButton.titleLabel?.font = UIFont(name: "MyriadPro-Light", size: 16)
//            setupTextView()
//            infoTextField.placeholder = "tap to edit"
//            infoTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingDidEnd)
//        } else {
//            infoTextField.font = UIFont(name: "MyriadPro-Regular", size: 16)
//            countryButton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 16)
//            infoTextField.placeholder = ""
//        }
        
    }
    
    private func setupTextView() {
        editingTextView.font = UIFont(name: "MyriadPro-Light", size: 16)
        editingTextView.translatesAutoresizingMaskIntoConstraints = true
        editingTextView.sizeToFit()
        editingTextView.isScrollEnabled = false
        editingTextView.becomeFirstResponder()
        editingTextView.backgroundColor = self.backgroundColor
    }
    
    func configure(withTitle: String, value: String?, isEditing: Bool, index: Int) {
        
        setupTextField(with: value ?? "")
        
        indexCell = index
        if index.isMultiple(of: 2) {
            cellView.backgroundColor = .white
        } else {
            cellView.backgroundColor = .systemGray6
        }
        isProfileEditing = isEditing
        titleLabel.text = withTitle
        
    }
    
    func configureIsEnabled(withTitle: String, value: String?, isEditing: Bool, indexPath: Int) {
        
        setupTextField(with: value ?? "")
        
        if indexPath.isMultiple(of: 2) {
            cellView.backgroundColor = .white
        } else {
            cellView.backgroundColor = .systemGray6
        }
        isProfileEditing = isEditing
        titleLabel.text = withTitle
        
    }
    
}
