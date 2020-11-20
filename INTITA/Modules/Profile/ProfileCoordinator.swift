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
        
        //childCoordinators.append(SystemProfileCoordinator())
        //childCoordinators.append(MessagesCoordinator())
        //childCoordinators.append(OpportunitiesCoordinator())
        //childCoordinators.append(TasksCoordinator())
        //childCoordinators.append(SettingsCoordinator())
    }

    func start() {
        let vc = ProfileViewController.instantiate()
        let viewModel = ProfileViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showLoginScreen() {
        navigationController.popViewController(animated: true)
    }
}

extension ProfileCoordinator: ProfileHeaderViewDelegate {
    func avatarTapped() {
        guard let systemProfileCoordinator = childCoordinators.first else { return }
        systemProfileCoordinator.start()
    }
}

extension ProfileCoordinator: ProfileTableViewCellDelegate {
    func goToVC(number: Int) {
        guard number < childCoordinators.count else { return }
        childCoordinators[number].start()
    }
}
