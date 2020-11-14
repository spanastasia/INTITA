//
//  LinksTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 12.11.2020.
//

import UIKit

protocol LinksTableViewCellDelegate: AnyObject {
    func linksTableViewCellDidPressRegister(_ sender: LinksTableViewCell)
    func linksTableViewCellDidPressForgotPassword(_ sender: LinksTableViewCell)
}
class LinksTableViewCell: UITableViewCell {
    
    weak var delegate: LinksTableViewCellDelegate?

    @IBAction func didPressForgotPassButton(_ sender: UIButton) {
        delegate?.linksTableViewCellDidPressForgotPassword(self)
    }
    @IBAction func didPressRegisterButton(_ sender: UIButton) {
        delegate?.linksTableViewCellDidPressRegister(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
