//
//  ProfileTableViewCell.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.shadowed(shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
