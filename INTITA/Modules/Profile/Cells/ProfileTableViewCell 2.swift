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
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(containerAction))
        container.addGestureRecognizer(tapGR)
        container.isUserInteractionEnabled = true
    }

    @objc func containerAction() {
        
    }
    
}
