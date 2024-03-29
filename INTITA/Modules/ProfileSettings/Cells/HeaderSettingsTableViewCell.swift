//
//  HeaderSettingsTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 19.12.2020.
//

import UIKit

protocol HeaderSettingsTableViewCellDelegate: AnyObject {
    func editTapped(_ sender: HeaderSettingsTableViewCell)
    func goToProfileScreen()
}

class HeaderSettingsTableViewCell: UITableViewCell, NibCapable {
    
    weak var delegate: HeaderSettingsTableViewCellDelegate!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var specializationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()

    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate.editTapped(self)
    }
    
    @IBAction func editImageButtonTapped(_ sender: UIButton) {
        delegate.editTapped(self)
    }
   
    @IBAction func backBattonTapped(_ sender: Any) {
        delegate.goToProfileScreen()
    }
    
    private func setupCell() {
        
        guard let user = UserData.currentUser else { return }
        if let secondName = user.secondName {
            nameLabel.text = "\(user.firstName) \(secondName)"
        } else {
            nameLabel.text = "\(user.firstName)"
        }
        
        specializationLabel.text = user.preferSpecializations.first?.specialization.title
        guard let url = user.avatar else { return }
        
        avatarView.image = (try? UIImage(data: Data(contentsOf: url))) ?? UIImage(named: "defaultAvatar")
        
        avatarView.rounded(cornerRadius: avatarView.frame.width / 2)
        
        setupEditBtn(isTrue: false)
        mainView.rounded(cornerRadius: 5, roundOnlyBottomCorners: true)
        mainView.shadowed()
    }
    
    func setupEditBtn(isTrue: Bool) {

        if isTrue {
            editButton.setTitle("save".localized, for: .normal)
            editImageButton.setImage(UIImage(named: "checkDone"), for: .normal)
        } else {
            editButton.setTitle("edit".localized, for: .normal)
            editImageButton.setImage(UIImage(named: "editBtn"), for: .normal)
        }
    }
}
