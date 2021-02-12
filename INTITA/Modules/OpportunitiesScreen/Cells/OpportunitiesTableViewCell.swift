//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

protocol OpportunitiesTableViewCellDelegate: AnyObject {
    func changeSizeCell(sender: OpportunitiesTableViewCell, index: OpportunitiesType.RawValue)
}

class OpportunitiesTableViewCell: UITableViewCell, NibCapable {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstLineView: UIView!
    
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var delegate: OpportunitiesTableViewCellDelegate?
    var type: OpportunitiesType?
    
    var isProfileSize = false {
        didSet {
            if isProfileSize {
                configureExtendedView()
            } else {
                configureSmallView()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureSmallView() {
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let type = type else { return }
  
        stackView.isHidden = true
        firstLineView.isHidden = true
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        rotateButton(false)
        
        mainLabel.text = type.sectionTitle
        infoLabel.text = type.sectionInfo
    }
    
    func configureExtendedView() {
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let type = type else { return }
        
        firstLineView.isHidden = false
        stackView.isHidden = false

        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        rotateButton(true)

        mainLabel.text = type.sectionTitle
        infoLabel.text = type.sectionInfo

        setupStackView()
    }
    
    func setupStackView() {
        guard let type = type else { return }
        
        for index in 0..<type.items.count {
            
            if type.items.count == 1 || index == (type.items.count - 1) {
                let button = UIButton()
                setupButton(button: button, title: type.items[index])
            } else {
                let button = UIButton()
                let view = UIView()
                setupButton(button: button, title: type.items[index])
                setupLine(view: view)
            }
        }

    }
    
    func setupLine(view: UIView) {
        
        view.backgroundColor = UIColor.primaryColor
        
        view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        stackView.addArrangedSubview(view)
        
    }
    
    func setupButton(button: UIButton, title: String) {

        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        button.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 0).isActive = true
        button.topAnchor.constraint(equalTo: button.topAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.addArrangedSubview(button)
        
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        
        if let type = type {
            delegate?.changeSizeCell(sender: self, index: type.rawValue)
        }
    }

    func rotateButton(_ expanded: Bool) {

        UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations:  {
            self.downButton.transform = CGAffineTransform
                .identity
                .rotated(by: expanded ? .zero : .pi)
        }).startAnimation()
    }
}
