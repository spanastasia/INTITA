//
//  LinksTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 13.11.2020.
//

import UIKit

protocol LinksTableViewCellDelegate: AnyObject {
    func linksTableViewCellDidPressRegister(_ sender: LinksTableViewCell)
    func linksTableViewCellDidPressForgotPassword(_ sender: LinksTableViewCell)
}

class LinksTableViewCell: UITableViewCell, NibCapable {
    
    
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    weak var delegate: LinksTableViewCellDelegate?

    @IBAction func forgotPassTapped(_ sender: UIButton) {
        delegate?.linksTableViewCellDidPressForgotPassword(self)
    }
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        delegate?.linksTableViewCellDidPressRegister(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setButtonAtribut(title: String) {
        
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let forgotPassAttributeString = NSMutableAttributedString(string: title.localized, attributes: buttonAttributes)
        let registerAttributeString = NSMutableAttributedString(string: "register".localized, attributes: buttonAttributes)
        
        forgotPassButton.setAttributedTitle(forgotPassAttributeString, for: .normal)
        registerButton.setAttributedTitle(registerAttributeString, for: .normal)
    }
}
