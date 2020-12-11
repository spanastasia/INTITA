//
//  LogInCoordinator.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import Foundation
import UIKit

class LogInCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LogInViewController.instantiate()
        let viewModel = LogInViewModel()
        vc.coordinator = self
        viewModel.delegate = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func forgotPasswordScreen() {
        let forgotPasswordScreen = ForgotPasswordCoordinator(navigationController: navigationController)
        forgotPasswordScreen.start()
    }
}

extension LogInCoordinator: LogInViewModelDelegate {
    func loginSuccess() {
        let successCoordinator = ProfileCoordinator(navigationController: navigationController)
        childCoordinators.append(successCoordinator)
        DispatchQueue.main.async {
            successCoordinator.start()
        }
    }
}
