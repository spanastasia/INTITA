//
//  PromoTextView.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 01.11.2020.
//

import UIKit

class PromoTextView: UIView {
    
//    private var textView = UITextView()
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
//        self.textView.text = promoText
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
//        textView.isUserInteractionEnabled = false
        textLabel.isUserInteractionEnabled = false
//        textView.textColor = UIColor(named: "mainColor")
        textLabel.textColor = UIColor(named: "mainColor")
//        textView.font = UIFont.systemFont(ofSize: 84)
//        textLabel.adjustsFontForContentSizeCategory = true
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
        textLabel.baselineAdjustment = .alignBaselines
        textLabel.lineBreakMode = .byClipping
//        textLabel.font = UIFont.systemFont(ofSize: 74)
//        textView.adjustsFontForContentSizeCategory = true

        
//        textView.textAlignment = .center
//        textView.sizeToFit()
//        textView.isScrollEnabled = false
//        textView.backgroundColor = .clear
        textLabel.textAlignment = .center
        textLabel.sizeToFit()
//        textLabel.accessibilityScroll(.)
        
        textLabel.backgroundColor = .clear
        
//        textView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textView)
//        self.clipsToBounds = false
        self.addSubview(textLabel)
        
//        textCenterXAnchor = textView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        textCenterXAnchor = textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        NSLayoutConstraint.activate([
//            textView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            textCenterXAnchor,
//            textView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textCenterXAnchor,
            textLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
    }
    
    func updateViewCenterXAnchor(with constant: CGFloat) {
//        textCenterXAnchor = self.textView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
        textCenterXAnchor = self.textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
    }
}
