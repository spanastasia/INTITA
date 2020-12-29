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
}
