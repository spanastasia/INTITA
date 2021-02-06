//
//  OpportunitiesTableViewCell.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

protocol OpportunitiesTableViewCellDelegate: AnyObject {
    func downButtonTapped(sender: OpportunitiesTableViewCell, withIndexPath: Opportunities.RawValue)
}

class OpportunitiesTableViewCell: UITableViewCell, NibCapable {
    
    var delegate: OpportunitiesTableViewCellDelegate?
    var type: Opportunities?
    // - TODO:  get rid of spacing
    var spacing: CGFloat = 28
    
    var isProfileSize = false {
        didSet {
            if isProfileSize {
                configureExtendedView()
            } else {
                configureSmallView()
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
    
    // - TODO: remove it please
    override func layoutSubviews() {
        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
//        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    func configureSmallView() {
        
        guard let type = type else { return }
        
        mainView.bordered(borderWidth: 1, borderColor: UIColor.primaryColor.cgColor)
        mainView.rounded()
        
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

        mainLabel.text = type.sectionTitle
        infoLabel.text = type.sectionInfo
        
        
        if type.itemsCount > 1 {
            // StackView.arrangedSubviews.append( [Button + Separator, ..] + Button)
            firstLineView.isHidden = false
            secondLineView.isHidden = false
            
            taskButton.isHidden = false
            financeButton.isHidden = false
            
            taskButton.setTitle(type.sectionButonTask, for: .normal)
            financeButton.setTitle(type.sectionButonFinance, for: .normal)
            
        } else {
            // StackView.arrangedSubviews.append(Button)
            taskButton.isHidden = false
            firstLineView.isHidden = false
            
            taskButton.setTitle(type.sectionButonTask, for: .normal)
        }
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        
        if let type = type {
            delegate?.downButtonTapped(sender: self, withIndexPath: type.rawValue)
        }
    }
    
    func rotateButton(_ expanded: Bool) {
        // TODO: fix the downButton behaviour
        UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations:  {
            self.downButton.transform = CGAffineTransform
                .identity
                .rotated(by: expanded ? .zero : .pi)
            
        }).startAnimation()
    }
        
}
