//
//  ForgotPasswordCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.11.2020.
//

import UIKit

class ForgotPasswordCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ForgotPasswordViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func returnToLoginScreen() {
        
        navigationController.popViewController(animated: true)
    }
}
