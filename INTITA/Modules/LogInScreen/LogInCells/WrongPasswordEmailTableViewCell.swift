//
//  WrongPasswordEmailTableViewCell.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 09.04.2021.
//

import UIKit

class WrongPasswordEmailTableViewCell: UITableViewCell, NibCapable{

    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        errorLabel.isHidden = true
    }
}
