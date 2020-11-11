//
//  AlertView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import UIKit

class AlertView: UIView {
    
    //MARK:- Outlets
    @IBOutlet private weak var errorHeader: UILabel!
    
    @IBOutlet private weak var errorMessage: UITextView!
    @IBOutlet private weak var backButton: UIButton!
    
    //MARK:- Actions
    @IBAction func backButtonTapped() {
        hide()
    }
    
    //MARK:- Methods
    func customizeAndShow(header: String = "error occured".localized, message: String, buttonTitle: String = "back".localized) {
        if !setUped {
            setUp()
        }
        errorHeader.text = header
        backButton.setTitle(buttonTitle, for: .normal)
        
        let string = NSMutableAttributedString()
        string.append(NSAttributedString(string: message + "\n\n"))
        string.append(contacts)
        errorMessage.attributedText = string
        errorMessage.font = UIFont.primaryFontLight.withSize(16)
        errorMessage.textAlignment = .center
        show()
    }
    
    func show() {
        animator.startAnimation()
    }
    func hide() {
        animator.startAnimation()
    }
    
    //MARK:- Private properties
    private var setUped = false
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    private var animator: UIViewPropertyAnimator {
        let alpha: CGFloat = self.alpha == 0 ? 1 : 0
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            self.alpha = alpha
            self.blurEffectView.alpha = alpha
        }
        return animator
    }
    
    private var contacts: NSAttributedString {
        let string = NSMutableAttributedString()
        let text = "get more info".localized
        var phoneNumberAttributes: [NSAttributedString.Key: Any] = [
            .link: URL(string: "tel://" + AppConstans.phoneNumber1.replacingOccurrences(of: " ", with: ""))!,
            ]
        let phoneNumber1 = NSAttributedString(string: AppConstans.phoneNumber1, attributes: phoneNumberAttributes)
        phoneNumberAttributes = [ .link: URL(string: "tel://" + AppConstans.phoneNumber2.replacingOccurrences(of: " ", with: ""))! ]
        let phoneNumber2 = NSAttributedString(string: AppConstans.phoneNumber2, attributes: phoneNumberAttributes)
        string.append(NSAttributedString(string: text + "\n"))
        string.append(phoneNumber1)
        string.append(NSAttributedString(string: "\n"))
        string.append(phoneNumber2)
        return string
    }
    
    //MARK:- Private methods
    private func setUp() {
        guard let superview = self.superview else { return }
        
        errorHeader.shadowed()
        
        backButton.backgroundColor = UIColor.white
        
        backButton.bordered()
        backButton.rounded()
        backButton.shadowed(shadowColor: UIColor.primaryColor.cgColor)
        backButton.titleLabel?.shadowed()
        self.shadowed(shadowOffset: CGSize(width: 4, height: 4), shadowRadius: 16, shadowOpacity: 0.4)
        
        setUpBlurEffect(superview: superview)
        
        superview.bringSubviewToFront(self)
        self.alpha = 0
        setUped = true
    }
    
    private func setUpBlurEffect(superview: UIView) {
        blurEffectView.frame = superview.bounds
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        blurEffectView.addGestureRecognizer(gesture)
        
        blurEffectView.isUserInteractionEnabled = true
        
        blurEffectView.alpha = 0
        
        superview.addSubview(blurEffectView)
        
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 24).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -24).isActive = true
        NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: -20).isActive = true
    }
}
