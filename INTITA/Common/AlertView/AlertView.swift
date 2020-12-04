//
//  AlertView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import UIKit

class AlertView: UIView {
    
    //MARK:- Outlets
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var errorHeader: UILabel!
    @IBOutlet weak var errorMessage: UITextView!
    @IBOutlet private weak var backButton: UIButton!
    
    //MARK:- Methods
    func customizeAndShow(header: String = "error occured".localized, message: String, buttonTitle: String = "back".localized) {
            errorHeader.shadowed()
            
            backButton.backgroundColor = UIColor.white
            backButton.bordered()
            backButton.rounded()
            backButton.shadowed(shadowColor: UIColor.primaryColor.cgColor)
            backButton.titleLabel?.shadowed()
            
            alertView.shadowed(shadowOffset: CGSize(width: 4, height: 4), shadowRadius: 16, shadowOpacity: 0.4)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(hide))
            gesture.delegate = self
            blurView.addGestureRecognizer(gesture)
            self.alpha = 0
        
        errorHeader.text = header
        backButton.setTitle(buttonTitle, for: .normal)
        
        let string = NSMutableAttributedString()
        string.append(NSAttributedString(string: message + "\n\n"))
        string.append(contacts)
        errorMessage.attributedText = string
        errorMessage.font = UIFont.primaryFontLight.withSize(16)
        errorMessage.textAlignment = .center
        errorMessage.textColor = .black
        animator.startAnimation()
    }
    
    //MARK:- Private properties
    
    private var animator: UIViewPropertyAnimator {
        let alpha: CGFloat = self.alpha == 0 ? 1 : 0
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            self.alpha = alpha
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
    
    @objc private func hide() {
        animator.startAnimation()
        removeFromSuperview()
    }
}

extension AlertView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var point = touch.location(in: backButton)
        if backButton.frame(forAlignmentRect: self.frame).contains(point) {
            return true
        }
        point = touch.location(in: self)
        if alertView.frame.contains(point) {
            return false
        }
        return true
    }
}
