//
//  AlertView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import UIKit

class AlertView: UIView {
    
    @IBOutlet weak var errorHeader: UILabel!
    
    @IBOutlet weak var errorMessage: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonTapped() {
        hideAlert()
    }
    
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
    
    private let shadowRadius: CGFloat = 4
    private let shadowOpacity: Float = 0.25
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadView() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setUp() {
        guard let superview = self.superview else { return }
        
        errorHeader.layer.shadowRadius = shadowRadius
        errorHeader.layer.shadowColor = UIColor.black.cgColor
        errorHeader.layer.shadowOffset = CGSize(width: 0, height: 4)
        errorHeader.layer.shadowOpacity = shadowOpacity
        backButton.backgroundColor = UIColor.white
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        backButton.layer.cornerRadius = 10
        backButton.layer.shadowColor = UIColor(named: "mainColor")?.cgColor
        backButton.layer.shadowRadius = shadowRadius
        backButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        backButton.layer.shadowOpacity = shadowOpacity
        backButton.titleLabel?.layer.shadowRadius = shadowRadius
        backButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        backButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 4)
        backButton.titleLabel?.layer.shadowOpacity = shadowOpacity
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 16
        
        blurEffectView.frame = superview.bounds
        let gesture = UIGestureRecognizer(target: blurEffectView, action: #selector(blurEffectViewTapped))
        blurEffectView.addGestureRecognizer(gesture)
        
        superview.addSubview(blurEffectView)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 24).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -24).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 196).isActive = true
        
        superview.bringSubviewToFront(self)
        self.alpha = 0
        blurEffectView.alpha = 0
    }
    
    func customize(header: String = "error occured".localized, message: String, buttonTitle: String = "back".localized) {
        errorHeader.text = header
        backButton.setTitle(buttonTitle, for: .normal)
        
        let string = NSMutableAttributedString()
        string.append(NSAttributedString(string: message + "\n\n"))
        string.append(contacts)
        errorMessage.attributedText = string
    }
    
    @objc func blurEffectViewTapped(_ sender: UIGestureRecognizer) {
        hideAlert()
    }
    
    func showAlert() {
        animator.startAnimation()
    }
    func hideAlert() {
        animator.startAnimation()
    }
    
    
}
