//
//  HeaderSettingsTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

protocol HeaderSettingsTableViewCellDelegate: AnyObject {
    func editTaped(_ sender: HeaderSettingsTableViewCell)
    func goToProfileScreen()
}

class HeaderSettingsTableViewCell: UITableViewCell, NibCapable {
    
    weak var delegate: HeaderSettingsTableViewCellDelegate!

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
    
    @IBAction func backBattonTaped(_ sender: Any) {

        delegate.goToProfileScreen()
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
