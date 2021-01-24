//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var coordinator: OpportunitiesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sutupNameLabel()

    }
    
    func sutupNameLabel() {
        nameLabel.text = "opportunities".localized
    }
    
    @IBAction func backButtonTappet(_ sender: UIButton) {
        
        coordinator?.returnToProfileScreen()
    }
    
}
