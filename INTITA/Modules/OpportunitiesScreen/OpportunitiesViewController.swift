//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    @IBOutlet weak var availableOptionsLabel: UILabel!
    
    var coordinator: OpportunitiesCoordinator?
    private lazy var contentView: OpportunitiesTableViewCell = .fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sutupNameLabel()
        
        setupFirstView()
//        taskView.addSubview(contentView)

    }
    
    func sutupNameLabel() {
        nameLabel.text = "opportunities".localized
    }
    
    func setupFirstView() {
        
        taskView.bordered(borderWidth: 1, borderColor: UIColor.black.cgColor)
        taskView.rounded(cornerRadius: 10)
        heightOfView.constant = 120
        taskView.frame.size.width = view.frame.width - 56
        taskView.frame.size.height = 120
        taskView.addSubview(contentView)
    }
    
    @IBAction func backButtonTappet(_ sender: UIButton) {
        
        coordinator?.returnToProfileScreen()
    }
    
}
