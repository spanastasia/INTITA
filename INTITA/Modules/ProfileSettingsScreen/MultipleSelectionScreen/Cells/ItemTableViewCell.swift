//
//  ItemTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

class ItemTableViewCell: UITableViewCell, NibCapable {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupUI()
        isUserInteractionEnabled = true
    }
    
    private func setupUI(isTrue: Bool) {
        colorView.rounded()
        let fontText: UIFont = isTrue ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 14)
        valueLabel.font = fontText
        let color: UIColor = isTrue ? .systemGray4 : .systemGray6
        colorView.backgroundColor = color
    }
    
    func configure(with item: ButtonItem) {
        setupUI(isTrue: item.enabled)
        valueLabel.text = item.title
    }
    
}
