//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var financeLabel: UILabel!
    
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        
    }
    
    
}
