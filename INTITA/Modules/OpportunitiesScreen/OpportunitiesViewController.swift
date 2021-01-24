//
//  OpportunitiesViewController.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import UIKit

class OpportunitiesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameScreenLabel: UILabel!
    var coordinator: OpportunitiesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backButtonTappet(_ sender: UIButton) {
        
        coordinator?.returnToProfileScreen()
    }
    
}
