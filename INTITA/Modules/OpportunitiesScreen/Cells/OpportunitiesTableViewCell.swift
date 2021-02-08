//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

protocol OpportunitiesTableViewCellDelegate: AnyObject {
    func changeSizeCell(sender: OpportunitiesTableViewCell, index: OpportunitiesModel.RawValue)
}

class OpportunitiesTableViewCell: UITableViewCell, NibCapable {
    
    var delegate: OpportunitiesTableViewCellDelegate?
    var type: OpportunitiesModel?
    
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        for index in 0..<type.items.count {
            
        }
        
        if type.items.count == 1 {
            // StackView.arrangedSubviews.append(Button)
            taskButton.isHidden = false
            firstLineView.isHidden = false
            
            financeButton.isHidden = true
            secondLineView.isHidden = true
            
            taskButton.setTitle(type.sectionButonTask, for: .normal)
            
        } else {
            // StackView.arrangedSubviews.append( [Button + Separator, ..] + Button)
            firstLineView.isHidden = false
            secondLineView.isHidden = false
            
            taskButton.isHidden = false
            financeButton.isHidden = false
            
            taskButton.setTitle(type.sectionButonTask, for: .normal)
            financeButton.setTitle(type.sectionButonFinance, for: .normal)
        }

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
