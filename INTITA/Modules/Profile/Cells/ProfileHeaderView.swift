//
//  ProfileHeaderView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func avatarTapped()
}

protocol ProfileHeaderViewDataSourse: AnyObject {
    func editImage()
}

class ProfileHeaderView: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specializationLabel: UILabel!
    
    weak var delegate: ProfileHeaderViewDelegate?
    weak var dataSourse: ProfileHeaderViewDataSourse?
    
    //MARK: - awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarView.addGestureRecognizer(tapGR)
        avatarView.isUserInteractionEnabled = true
        avatarView.rounded(cornerRadius: avatarView.frame.width / 2)
        setupContainer()
        
        guard let user = UserData.currentUser else {
            return
        }
        nameLabel.text = "\(user.firstName) \(user.secondName)"
        
        specializationLabel.text = user.preferSpecializations.first?.specializationId.description
        guard let url = user.avatar else {
            return
        }
        avatarView.image = (try? UIImage(data: Data(contentsOf: url))) ?? UIImage(named: "defaultAvatar")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        drawGappedBorder()
    }
    
    //MARK: - Actions
    @IBAction func editBtnTapped() {
        dataSourse?.editImage()
    }
    
    @objc func avatarTapped() {
        delegate?.avatarTapped()
    }
    
    //MARK: - Methods
    
    
    //MARK: - Private methods
    private func drawGappedBorder() {
        drawArc(from: 25, to: 312)
        drawArc(from: 283, to: 175)
        drawArc(from: 170, to: 40)
    }
    
    private func drawArc(from start: Int, to end: Int) {
        let shape = CAShapeLayer()
        let radius = avatarView.frame.width / 2 + 12
        shape.lineWidth = 1
        let path = UIBezierPath()
        let x = superview?.center.x
        let y = (superview?.safeAreaLayoutGuide.layoutFrame.height)! * 0.2 - 4
        path.addArc(withCenter: CGPoint(x: x!, y: y), radius: radius, startAngle: CGFloat(start).toRadians(), endAngle: CGFloat(end).toRadians(), clockwise: false)
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        superview?.layer.addSublayer(shape)
    }
    
    private func setupContainer() {
        container.rounded(cornerRadius: 5)
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.shadowed()
    }
}
