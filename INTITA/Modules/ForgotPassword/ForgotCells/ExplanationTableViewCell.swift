//
//  ExplanationTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 21.11.2020.
//

import UIKit

class ExplanationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var explanationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupExplanationLabel()
    }
    
    setupExplanationLabel() {
        
    }
    
}
