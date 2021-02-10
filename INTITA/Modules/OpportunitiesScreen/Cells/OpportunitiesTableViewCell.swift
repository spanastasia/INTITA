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
    
    @IBOutlet weak var arrayButtons: UIButton!
    
    @IBOutlet weak var arrayLines: UIView!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var financeButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupStackView()
    }
    
    func configureSmallView() {
        
        guard let type = type else { return }
  
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        rotateButton(false)
        
        mainLabel.text = type.sectionTitle
        infoLabel.text = type.sectionInfo

        taskButton.isHidden = true
        financeButton.isHidden = true

        firstLineView.isHidden = true
        secondLineView.isHidden = true
        
    }
    
    func configureExtendedView() {
        
        guard let type = type else { return }

        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        rotateButton(true)

        mainLabel.text = type.sectionTitle
        infoLabel.text = type.sectionInfo
        
        if type.items.count == 1 {
            // StackView.arrangedSubviews.append(Button)
            taskButton.isHidden = false
            firstLineView.isHidden = false
            
            financeButton.isHidden = true
            secondLineView.isHidden = true
            
            taskButton.setTitle(type.items[0], for: .normal)
            
        } else {
//            setupStackView()
            // StackView.arrangedSubviews.append( [Button + Separator, ..] + Button)
            firstLineView.isHidden = false
            secondLineView.isHidden = false
            
            taskButton.isHidden = false
            financeButton.isHidden = false
            
            taskButton.setTitle(type.items[0], for: .normal)
            financeButton.setTitle(type.items[1], for: .normal)
        }

    }
    
    func setupStackView() {
        guard let type = type else { return }
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if type.items.count == 1 {
            let button = UIButton()
            setupButton(button: button, title: type.items[type.rawValue])
        } else {
            for index in 0..<type.items.count {
                let button = UIButton()
                let view = UIView()
                setupLine(view: view)
                setupButton(button: button, title: type.items[index])
            }
        }
    }
    
    func setupLine(view: UIView) {
        
        view.backgroundColor = UIColor.primaryColor
        
        view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
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
