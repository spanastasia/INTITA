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
    let settingsViewModel: SettingsProfileViewModel
    
    var existingUser: CurrentUser

    init(
        navigationController: UINavigationController,
         existingUser: CurrentUser
    ) {
        self.navigationController = navigationController
        self.existingUser = existingUser
        
        settingsViewModel = SettingsProfileViewModel(existingUser: existingUser)
    }

    func start() {
        let settingsViewController = SettingsProfileViewController.instantiate()
        settingsViewController.coordinator = self
        
        settingsViewController.viewModel = settingsViewModel
        
        navigationController.pushViewController(settingsViewController, animated: true)
    }
    
    func returnToProfileScreen() {
        navigationController.popViewController(animated: true)
    }
    
    func showListScreen() {
        let listCoordinator = ListCoordinator(
            navigationController: navigationController,
            selectedItem: settingsViewModel.selectedItem,
            items: settingsViewModel.item ?? []
        )
        
        listCoordinator.delegate = self
        listCoordinator.start()
    }
    
    func showBirthdayScreen() {
        let birthdayCoordinator = BirthdayCoordinator(navigationController: navigationController)
        birthdayCoordinator.start()
    }
}

extension SettingsProfileCoordinator: ListCoordinatorDelegate {
    func listViewController(_ sender: Coordinator, didSelectItem: LocalizedResponseProtocol) {
        settingsViewModel.selectItem(didSelectItem)
    }
}
