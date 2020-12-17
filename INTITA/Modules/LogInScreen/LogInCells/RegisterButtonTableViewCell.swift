//
//  RegisterButtonTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 13.11.2020.
//

import UIKit

protocol RegisterButtonTableViewCellDelegate: AnyObject {
    func didPressLogInButton(_ sender: RegisterButtonTableViewCell)
}

class RegisterButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logInButton: UIButton!
    weak var delegate: RegisterButtonTableViewCellDelegate?

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        delegate?.didPressLogInButton(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logInButton.rounded(cornerRadius: 15.0)
    }
}
