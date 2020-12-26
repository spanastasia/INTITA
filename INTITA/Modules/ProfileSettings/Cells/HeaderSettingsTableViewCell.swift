//
//  HeaderSettingsTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

protocol HeaderSettingsTableViewCellDelegate: AnyObject {
    func editTaped(_ sender: HeaderSettingsTableViewCell)
}

class HeaderSettingsTableViewCell: UITableViewCell {
    
    weak var delegate: HeaderSettingsTableViewCellDelegate!
    static let identifire = "HeaderSettingsTableViewCell"

    @IBOutlet weak var mainView: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var specializationLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()

    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
        delegate.editTaped(self)
                
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifire, bundle: nil)
    }
    
    private func setupCell() {
        
        guard let user = UserData.currentUser else { return }
        nameLabel.text = "\(user.firstName) \(user.secondName)"
        
        specializationLabel.text = user.preferSpecializations.first?.specialization.title
        guard let url = user.avatar else { return }
        
        avatarView.image = (try? UIImage(data: Data(contentsOf: url))) ?? UIImage(named: "defaultAvatar")
        
        avatarView.rounded(cornerRadius: avatarView.frame.width / 2)
        
        mainView.rounded(cornerRadius: 5, roundOnlyBottomCorners: true)
        mainView.shadowed()
    }
    
}
