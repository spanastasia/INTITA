//
//  SendButtonTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 21.11.2020.
//

import UIKit

protocol SendButtonTableViewCellDelegate: AnyObject {
    func didPressSendButton(_ sender: SendButtonTableViewCell)
}

class SendButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sendButton: UIButton!
    
    weak var delegate: SendButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSendButton()
    }

    func setupSendButton() {
        
        sendButton.setTitle("send".localized, for: .normal)
        sendButton.titleLabel?.font = UIFont.primaryFontRegular
        sendButton.rounded()
        sendButton.shadowed()
    }
    
    @IBAction func tappedSendButton(_ sender: UIButton) {
        delegate?.didPressSendButton(self)
    }
    
}
