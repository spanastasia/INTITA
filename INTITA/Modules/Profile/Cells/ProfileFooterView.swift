//
//  ProfileFooterView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

protocol ProfileFooterViewDelegate: AnyObject {
    func logout()
}

class ProfileFooterView: UITableViewCell {
    weak var delegate: ProfileFooterViewDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBAction func exitBtnTapped(_ sender: UIButton) {
        delegate?.logout()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        label.sizeToFit()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.addGestureRecognizer(gesture)
    }
    
    @objc func labelTapped() {
        delegate?.logout()
    }
}
