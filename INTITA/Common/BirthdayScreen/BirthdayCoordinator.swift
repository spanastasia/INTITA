//
//  BirthdayCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 29.03.2021.
//

import UIKit

class  BirthdayCoordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let birthdayViewController = BirthdayViewController.instantiate()
        birthdayViewController.coordinator = self

        navigationController.present(birthdayViewController, animated: true)
    }
}
