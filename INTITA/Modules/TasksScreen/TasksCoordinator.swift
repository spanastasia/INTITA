//
//  TasksCoordinator.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import UIKit

class TasksCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TasksViewController.instantiate()
        let viewModel = TasksViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }

    func showProfileScreen() {
        navigationController.popViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}
