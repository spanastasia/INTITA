//
//  PromoTextView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 01.11.2020.
//

import UIKit

class PromoTextView: UIView {
    
    private var textLabel = UILabel()
    
    private var textCenterXAnchor = NSLayoutConstraint() {
        willSet {
            textCenterXAnchor.isActive = false
        }
        didSet {
            textCenterXAnchor.isActive = true
        }
    }
    
    init(promoText: String) {
        super.init(frame: .zero)
        setupText()
        self.textLabel.text = promoText
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText() {
        textLabel.isUserInteractionEnabled = false
        textLabel.textColor = UIColor(named: "mainColor")
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
        textLabel.baselineAdjustment = .alignBaselines
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = .center
        textLabel.sizeToFit()
        textLabel.backgroundColor = .clear
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textLabel)
        
        textCenterXAnchor = textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textCenterXAnchor,
            textLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
    }
    
    func updateViewCenterXAnchor(with constant: CGFloat) {
        textCenterXAnchor = self.textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
    }
}
