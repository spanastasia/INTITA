//
//  SettingsCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit

class SettingsProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let vc = SettingsProfileViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfileScreen() {
            navigationController.popViewController(animated: true)
//            navigationController.setNavigationBarHidden(true, animated: true)
//        let vc = ProfileViewController.instantiate()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
    }
    
}

//extension SettingsProfileCoordinator: HeaderSettingsTableViewCellDelegate {
//    func showProfileScreen() {
//            navigationController.popViewController(animated: true)
//            navigationController.setNavigationBarHidden(true, animated: true)
//    }
//
//}
