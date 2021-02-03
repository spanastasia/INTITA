//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

protocol OpportunitiesTableViewCellDelegate: AnyObject {
    func downButtonTapped(sender: OpportunitiesTableViewCell, withType: Opportunities)
}

class OpportunitiesTableViewCell: UITableViewCell, NibCapable {
    
    var delegate: OpportunitiesTableViewCellDelegate?
    var type: Opportunities?
    var isProfileSize = false {
        didSet {
            guard let type = type else { return }
            if isProfileSize {
                configureSmallView(with: type)
            } else {
                configureExtendedView(with: type)
            }
        }
    }

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var financeButton: UIButton!
    @IBOutlet weak var downButton: UIButton!

    @IBOutlet weak var downBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightMainViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureSmallView(with task: Opportunities) {
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        
        heightMainViewConstraint.constant = 75
        downBtnConstraint.constant = 8
        
        downButton.isHidden = false
        firstLineView.isHidden = true
        secondLineView.isHidden = true
        
        taskButton.isHidden = true
        financeButton.isHidden = true
        
        mainLabel.text = task.sectionTitle
        infoLabel.text = task.sectionInfo
    }
    
    func configureExtendedView(with task: Opportunities) {
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()

        heightMainViewConstraint.constant = 120
//        downBtnConstraint.constant =
        
        downButton.isHidden = true
        firstLineView.isHidden = false
        secondLineView.isHidden = false
        
        taskButton.isHidden = false
        financeButton.isHidden = false
        mainLabel.text = task.sectionTitle
        infoLabel.text = task.sectionInfo
    }
    
    @IBAction func downButtonTapped(_ sender: UIButton) {
        
        if let type = type {
            delegate?.downButtonTapped(sender: self, withType: type)
        }
    }
        
}
