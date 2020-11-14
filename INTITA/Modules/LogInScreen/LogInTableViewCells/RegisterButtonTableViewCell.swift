//
//  RegisterButtonTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 12.11.2020.
//

import UIKit

protocol RegisterButtonTableViewCellDelegate: AnyObject {
    func didPressLogInButton()
}

class RegisterButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var logInButton: UIButton!
    
    weak var delegate: RegisterButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logInButton.rounded(cornerRadius: 15.0)
        logInButton.setTitle("logIn".localized, for: .normal)
    }
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        delegate?.didPressLogInButton()
    }
}
