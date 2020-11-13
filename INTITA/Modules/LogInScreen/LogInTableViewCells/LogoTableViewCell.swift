//
//  LogoTableViewCell.swift
//  INTITA
//
//  Created by Stepan Niemykin on 12.11.2020.
//

import UIKit

class LogoTableViewCell: UITableViewCell {

    @IBOutlet weak var authLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        authLabel.text = "auth".localized
    }
    
}
