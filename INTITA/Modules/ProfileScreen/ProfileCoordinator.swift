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
    
    var profileViewModel: ProfileViewModel?

    init(navigationController: UINavigationController, user: CurrentUser) {
        self.navigationController = navigationController
        
        profileViewModel = ProfileViewModel()
    }

    func start() {
        let vc = ProfileViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = profileViewModel
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
        guard let user = UserData.currentUser else { return }
        let settingScreenCoordinator = SettingsProfileCoordinator(navigationController: navigationController, existingUser: user)
        settingScreenCoordinator.delegate = self
        settingScreenCoordinator.start()
    }
    
    func displayOpportunitiesScreen() {
        let OpportunitiesScreenCoordinator = OpportunitiesCoordinator(navigationController: navigationController)
        OpportunitiesScreenCoordinator.start()
    }
}

extension ProfileCoordinator: ProfileHeaderViewDelegate {
    func avatarTapped() {
        displaySettingsProfileScreen()
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

extension ProfileCoordinator: SettingsProfileCoordinatorDelegate {
    func settingsProfileCoordinator(_ sender: SettingsProfileCoordinator, user: CurrentUser) {
        profileViewModel?.setUser(at: user)
    }
}
