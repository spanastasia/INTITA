//
//  TextViewTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.04.2021.
//

import UIKit

class TextViewTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }
    
    func configure(with item: LabelItem) {
        titleLabel.text = item.title + ": "
        textView.text = item.value == nil ? "tap to edit".localized : item.value
    }
    
    private func setupTextView() {
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.becomeFirstResponder()
        textView.backgroundColor = self.backgroundColor
    }
}
