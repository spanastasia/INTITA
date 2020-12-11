//
//  LogoForgotTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 21.11.2020.
//

import UIKit

class LogoForgotTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImageView.rounded()
    }
    
}
