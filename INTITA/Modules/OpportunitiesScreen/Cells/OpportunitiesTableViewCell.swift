//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

protocol OpportunitiesTableViewCellDelegate: AnyObject {
    func increaseHeightOfView(withType: OpportunitiesView)
    func reduceHeightOfView(withType: OpportunitiesView)
}

class OpportunitiesTableViewCell: UITableViewCell {
    
    var delegate: OpportunitiesTableViewCellDelegate?
    var type: OpportunitiesView?
    var isProfileSize = false {
        didSet {
            if isProfileSize {
                configureSmallView()
            } else {
                configureExtendedView()
            }
        }
    }

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var financeLabel: UILabel!
    
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var heightOfViewConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureSmallView() {
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        
        heightOfViewConstraint.constant = 75
        
        upButton.isHidden = true
        downButton.isHidden = false
        firstLineView.isHidden = true
        secondLineView.isHidden = true
        
        taskLabel.text = ""
        financeLabel.text = ""
    }
    
    func configureExtendedView() {
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        
        heightOfViewConstraint.constant = 120
        
        upButton.isHidden = false
        downButton.isHidden = true
        firstLineView.isHidden = false
        secondLineView.isHidden = false
        
        taskLabel.text = "taskLabel"
        financeLabel.text = "financeLabel"
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        
//        print("downButtonTapped")
        if let type = type {
            delegate?.increaseHeightOfView(withType: type)
        }
    }
    
    @IBAction func upButtonTapped(_ sender: Any) {
//        print("upButtonTapped")
        if let type = type {
            delegate?.reduceHeightOfView(withType: type)
        }
    }
        
}
