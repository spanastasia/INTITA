//
//  LogInCoordinator.swift
//  INTITA
//
//  Created by Stepan Niemykin on 02.11.2020.
//

import Foundation
import UIKit
import SafariServices

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
        navigationController.pushViewController(vc, animated: true)
    }
    
    func forgotPasswordScreen(url: String) {
//        let forgotPasswordScreen = ForgotPasswordCoordinator(navigationController: navigationController)
//        forgotPasswordScreen.start()
        let safari = SFSafariViewController(url: URL(string: url)!)
                navigationController.present(safari, animated: true)
    }
}

extension LogInCoordinator: LogInViewModelDelegate {
    func loginSuccess(with user: CurrentUser) {
        let successCoordinator = ProfileCoordinator(navigationController: navigationController, user: user)
        childCoordinators.append(successCoordinator)
        DispatchQueue.main.async {
            successCoordinator.start()
        }
    }
}
