//
//  ViewController.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 29.10.2020.
//

import UIKit

class WelcomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: WelcomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("moto".localized)
    }


}

