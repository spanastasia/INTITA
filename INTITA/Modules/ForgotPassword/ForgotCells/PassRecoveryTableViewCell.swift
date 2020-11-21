//
//  PassRecoveryTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 21.11.2020.
//

import UIKit

class PassRecoveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var passRecoveryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        passRecoveryLabel.text = "passRecovery".localized
    }
    
}
