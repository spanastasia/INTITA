//
//  LabelTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.04.2021.
//

import UIKit

enum EnableCell {
    case link
    case text
    
    func isLinkEnable(isEditing: Bool) -> Bool {
        switch self {
        case .link:
            return true
        case .text:
            return false
        }
    }
}

class LabelTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var isItemEditing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: LabelItem) {
        titleLabel.text = item.title + ": "
        valueLabel.text = item.value
        
        isUserInteractionEnabled = !isItemEditing
    }
    
}
