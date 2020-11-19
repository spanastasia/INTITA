//
//  ProfileCoordinator.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        //append childCoordinators in needen order
        //system profile ccordinator
        //messages
        //...
        childCoordinators.append(LogInCoordinator(navigationController: navigationController))
    }

    func start() {
        let vc = ProfileViewController.instantiate()
        let viewModel = ProfileViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func presentLoginScreen() {
        childCoordinators.last?.start()
    }
}
