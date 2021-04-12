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
        
        setLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(setLabel), name: NSNotification.Name("errorLabel.isHidden"), object: nil)
        
    }
    
    @objc func setLabel() {
        errorLabel.isHidden = true
    }
}
