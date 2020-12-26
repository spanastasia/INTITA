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
//        childCoordinators.append(SettingsProfileCoordinator(navigationController: navigationController))
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
    
    func displaySettingsProfileScreen() {
        
        let settingScreenCoordinator = SettingsProfileCoordinator(navigationController: navigationController)
        
        
        settingScreenCoordinator.start()
    }
    
    func removeCoordinator(_ coordinator: Coordinator) {
        let index = childCoordinators.firstIndex { (child) -> Bool in
            child === coordinator
        }
        
        guard let childIndex = index else { return }
        
        childCoordinators.remove(at: childIndex)
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
            // Opportunities
            alertPresenter?.showAlert()
        case 2:
            // My tasks
            alertPresenter?.showAlert()
        case 3:
            displaySettingsProfileScreen()
        default:
            alertPresenter?.showAlert()
        }
    }
}
