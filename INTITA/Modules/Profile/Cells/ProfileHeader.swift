//
//  ProfileHeader.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileHeader: UITableViewCell {

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var avatarWrapperView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
   
    @IBAction func editBtnTapped() {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
