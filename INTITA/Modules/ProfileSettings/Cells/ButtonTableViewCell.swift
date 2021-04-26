//
//  ButtonTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.04.2021.
//

import UIKit

class ButtonTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: LabelItem) {
        titleLabel.text = item.title + ": "
        valueButton.setTitle(item.value, for: .normal)
        
        isUserInteractionEnabled = true
    }
    
}
