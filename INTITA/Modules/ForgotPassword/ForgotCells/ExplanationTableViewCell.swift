//
//  ExplanationTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 21.11.2020.
//

import UIKit

class ExplanationTableViewCell: UITableViewCell, NibCapable {
    
    @IBOutlet weak var explanationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupExplanationLabel()
    }
    
    func setupExplanationLabel() {
        
        explanationLabel.text = "textRecovery".localized
        explanationLabel.numberOfLines = 5
        explanationLabel.font = UIFont(name: "MyriadPro-Light", size: 16.0)
        explanationLabel.textAlignment = .justified
    }
    
}
