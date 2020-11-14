//
//  ProfileHeader.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileHeader: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var avatarWrapperView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specializationLabel: UILabel!
    
    
    //MARK: - awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupContainer()
        drawGappedBorder()
        
        guard let user = UserData.currentUser else {
            return
        }
        nameLabel.text = user.fullName
    }
    
    //MARK: - Actions
    @IBAction func editBtnTapped() {
    }
    
    //MARK: - Methods
    
    
    //MARK: - Private methods
    private func drawGappedBorder() {
        drawArc(from: 25, to: 308)
        drawArc(from: 275, to: 175)
        drawArc(from: 170, to: 40)
    }
    
    private func drawArc(from start: Int, to end: Int) {
        let shape = CAShapeLayer()
        let radius = avatarWrapperView.frame.width / 2
        shape.lineWidth = 1
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat(start).toRadians(), endAngle: CGFloat(end).toRadians(), clockwise: false)
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        avatarWrapperView.layer.addSublayer(shape)
    }
    
    private func setupContainer() {
        container.rounded(cornerRadius: 5)
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.shadowed()
    }
}
