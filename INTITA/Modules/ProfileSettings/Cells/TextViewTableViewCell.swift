//
//  TextViewTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 25.04.2021.
//

import UIKit

protocol TextViewTableViewCellDelegate: AnyObject {
    func textViewTableViewCell(_ sender: TextViewTableViewCell, didChangeText text: String)
}

class TextViewTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: TextViewTableViewCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
        textView.delegate = self
    }
    
    func configure(with item: LabelItem) {
        titleLabel.text = item.title + ": "
        textView.text = item.value == nil ? "tap to edit".localized : item.value
        index = item.id
        
        isUserInteractionEnabled = true
    }
    
    private func setupTextView() {
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.becomeFirstResponder()
        textView.backgroundColor = self.backgroundColor
    }
}

extension TextViewTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewTableViewCell(self, didChangeText: textView.text)
    }
}
