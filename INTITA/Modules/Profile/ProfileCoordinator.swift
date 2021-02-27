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
    
    let user: CurrentUser

    init(navigationController: UINavigationController, user: CurrentUser) {
        self.navigationController = navigationController
        self.user = user
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
    //2
    func displayTasksProfileScreen() {
        let tasksScreenCoordinator = TasksCoordinator(navigationController: navigationController)
        tasksScreenCoordinator.start()
    }
    //3
    func displaySettingsProfileScreen() {
        let settingScreenCoordinator = SettingsProfileCoordinator(navigationController: navigationController, existingUser: user)
        settingScreenCoordinator.start()
    }
    
    func displayOpportunitiesScreen() {
        let OpportunitiesScreenCoordinator = OpportunitiesCoordinator(navigationController: navigationController)
        OpportunitiesScreenCoordinator.start()
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
        switch number {
        case 0:
            //MessagesCoordinator
            alertPresenter?.showAlert()
        case 1:
            displayOpportunitiesScreen()
        case 2:
            displayTasksProfileScreen()
        case 3:
            displaySettingsProfileScreen()
        default:
            alertPresenter?.showAlert()
        }
    }
}
