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
    
    weak var delegat: SendButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSendButton()
    }

    func setupSendButton() {
        
        sendButton.setTitle("send".localized, for: .normal)
        sendButton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 24.0)
        sendButton.rounded()
        sendButton.shadowed()
    }
    
    @IBAction func tappedSendButton(_ sender: UIButton) {
        delegat?.didPressSendButton(self)
    }
    
}
