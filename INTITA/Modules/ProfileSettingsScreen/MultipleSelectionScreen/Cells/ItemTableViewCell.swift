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
        isUserInteractionEnabled = true
    }
    
    private func setupUI(isTrue: Bool) {
        colorView.rounded()
        animationView(by: isTrue)
    }
    
    func configure(with item: SelectedItem) {
        setupUI(isTrue: item.enabled)
        valueLabel.text = item.title
    }
    
    private func animationView(by isTrue: Bool) {
        let color: UIColor = isTrue ? .systemGray4 : .systemGray6
        let fontText: UIFont = isTrue ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 14)
        UIView.animate(withDuration: 0.5) {
            self.colorView.backgroundColor = color
            self.valueLabel.font = fontText
        }
    }
}
