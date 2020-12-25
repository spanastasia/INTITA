//
//  ProfileCoordinator.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 13.11.2020.
//

import UIKit

protocol ProfileCoordinatorAlertPresenter: AnyObject {
    func showAlert()
}

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var alertPresenter: ProfileCoordinatorAlertPresenter?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        //childCoordinators.append(SystemProfileCoordinator())
        //childCoordinators.append(MessagesCoordinator())
        //childCoordinators.append(OpportunitiesCoordinator())
        //childCoordinators.append(TasksCoordinator())
        childCoordinators.append(SettingsProfileCoordinator(navigationController: navigationController))
    }

    func start() {
        let vc = ProfileViewController.instantiate()
        let viewModel = ProfileViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        alertPresenter = vc
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showLoginScreen() {
        navigationController.popViewController(animated: true)
    }
    
    func settingsProfileScreen() {
        
        let settingScreen = SettingsProfileCoordinator(navigationController: navigationController)
        settingScreen.start()
    }
}

extension ProfileCoordinator: ProfileHeaderViewDelegate {
    func avatarTapped() {
        guard let systemProfileCoordinator = childCoordinators.first else {
            alertPresenter?.showAlert()
            return
        }
        systemProfileCoordinator.start()
    }
}

extension ProfileCoordinator: ProfileTableViewCellDelegate {
    func goToVC(number: Int) {
        guard number < childCoordinators.count else {
                alertPresenter?.showAlert()
            return
        }
            childCoordinators[number].start()        
    }
}
