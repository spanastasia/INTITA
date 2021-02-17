//
//  CountryTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var numberCountryLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
