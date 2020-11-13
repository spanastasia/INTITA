//
//  ProfileHeader.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileHeader: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var avatarWrapperView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
   
    @IBAction func editBtnTapped() {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.rounded(cornerRadius: 5)
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.shadowed()
        drawArc(around: avatarWrapperView, color: UIColor.white.cgColor, lineWidth: 1, from: 275, to: 308)
        drawArc(around: avatarWrapperView, color: UIColor.primaryColor.cgColor, lineWidth: 2, from: 40, to: 25)
        drawArc(around: avatarWrapperView, color: UIColor.primaryColor.cgColor, lineWidth: 2, from: 175, to: 170)
    }
    
    func drawArc(around view: UIView, color: CGColor, lineWidth: CGFloat, from start: Int, to end: Int) {
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: view.frame.width / 2, y: view.frame.width / 2), radius: view.frame.width / 2, startAngle: CGFloat(start).toRadians(), endAngle: CGFloat(end).toRadians(), clockwise: false)
        shape.path = path.cgPath
        shape.strokeColor = color
        shape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shape)
    }
    
}


extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
