//
//  ProfileTableViewCell.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

protocol ProfileTableViewCellDelegate: AnyObject {
    func goToVC(number: Int)
}

class ProfileTableViewCell: UITableViewCell, NibCapable {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var row: Int?
    weak var delegate: ProfileTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.shadowed(shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 10)
        container.rounded(cornerRadius: 5)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(containerAction))
        container.addGestureRecognizer(tapGR)
        container.isUserInteractionEnabled = true
        button.isUserInteractionEnabled = false
    }

    @objc func containerAction() {
        print("cell at row\(row!) tapped")
        guard let row = row else {
            return
        }
        delegate?.goToVC(number: row)
    }
    
}
