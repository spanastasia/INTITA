//
//  NotificationsCoordinator.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 22.04.2021.
//

import UIKit

class NotificationsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let vc = NotificationsViewController.instantiate()
        let viewModel = NotificationsViewModel()
        
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func returnToProfileScreen() {

        navigationController.popViewController(animated: true)
    }
    

    

}
