//
//  AlertView.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 05.11.2020.
//

import UIKit

class AlertView: UIView {
    
    @IBOutlet weak var errorHeader: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonTapped() {
        hideAlert()
    }
    
    private lazy var blurEffectFrame: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    private let shadowRadius: CGFloat = 4
    private let shadowOpacity: Float = 0.25
    
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
    
    func customize(superview: UIView, header: String, message: String, buttonTitle: String) {
        errorHeader.text = header
        errorMessage.text = message
        backButton.setTitle(buttonTitle, for: .normal)
        
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
        
        blurEffectFrame.frame = superview.bounds
        superview.addSubview(blurEffectFrame)
        superview.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 24).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -24).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 196).isActive = true
        self.isHidden = true
        blurEffectFrame.isHidden = true
    }
    
    func showAlert() {
        blurEffectFrame.isHidden = false
        self.isHidden = false
    }
    func hideAlert() {
        isHidden = true
        blurEffectFrame.isHidden = true
    }
    
    
}
