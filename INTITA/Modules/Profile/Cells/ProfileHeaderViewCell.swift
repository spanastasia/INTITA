//
//  ProfileHeaderViewCell.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func avatarTapped()
}

class ProfileHeaderViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specializationLabel: UILabel!
    @IBOutlet weak var avatarWrapper: UIView!
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    //MARK: - awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarView.addGestureRecognizer(tapGR)
        avatarView.isUserInteractionEnabled = true
        setupContainer()
        update()

        avatarView.rounded(cornerRadius: avatarView.frame.width / 2)
        avatarWrapper.rounded(cornerRadius: avatarWrapper.frame.width  / 2)
        avatarWrapper.bordered(borderWidth: 1, borderColor: UIColor.white.cgColor)
        editButton.rounded(cornerRadius: editButton.frame.width / 2)
    }
    
    //MARK: - Actions
    @IBAction func editBtnTapped() {
        delegate?.avatarTapped()
    }
    
    @objc func avatarTapped() {
        delegate?.avatarTapped()
    }
    
    //MARK: - Methods
    func update() {
        guard let user = UserData.currentUser else {
            return
        }
        guard let userDB = CoreDataService.retrieveDataFromDB(appUser: user) else {return}
        nameLabel.text = "\(userDB.firstName) \(userDB.secondName)"

        specializationLabel.text = userDB.preferSpecialization
        guard let url = userDB.avatar else {
            return
        }
        avatarView.image = (try? UIImage(data: Data(contentsOf: url))) ?? UIImage(named: "defaultAvatar")
    }
    private func setupContainer() {
        container.rounded(cornerRadius: 5, roundOnlyBottomCorners: true)
        container.shadowed()
    }
}
