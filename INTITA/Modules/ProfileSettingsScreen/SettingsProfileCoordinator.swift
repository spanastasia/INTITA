//
//  SettingsCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 18.12.2020.
//

import UIKit
import SafariServices

protocol SettingsProfileCoordinatorDelegate: AnyObject {
    func settingsProfileCoordinator(_ sender: SettingsProfileCoordinator, user: CurrentUser)
}

class SettingsProfileCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let settingsViewModel: SettingsProfileViewModel
    
    var existingUser: CurrentUser
    var delegate: SettingsProfileCoordinatorDelegate?

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
        guard let editing = settingsViewModel.editingUser,
              let user = CurrentUser(from: editing) else { return }
        delegate?.settingsProfileCoordinator(self, user: user)
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
        let birthdayCoordinator = BirthdayCoordinator(navigationController: navigationController,
                                                      selectedDate: settingsViewModel.selectedBirthday ?? "")
        birthdayCoordinator.delegate = self
        birthdayCoordinator.start()
    }
    
    func showMultipleSelectionScreen() {
        let multipleSelectionCoordinator = MultipleSelectionCoordinator(
            navigationController: navigationController,
            item: settingsViewModel.item ?? [],
            selectedItem: settingsViewModel.selectedItemEducations ?? [])
        
        multipleSelectionCoordinator.delegate = self
        multipleSelectionCoordinator.start()
    }
    
    func showSafari(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true)
    }

}

extension SettingsProfileCoordinator: ListCoordinatorDelegate {
    func listViewController(_ sender: Coordinator, didSelectItem: LocalizedResponseProtocol) {
        settingsViewModel.selectItem(didSelectItem)
    }
}

extension SettingsProfileCoordinator: BirthdayCoordinatorDelegate {
    func birthdayCoordinator(_ sender: Coordinator, didSelectDay: String) {
        settingsViewModel.selectBirthday(didSelectDay)
    }
}

extension SettingsProfileCoordinator: MultipleSelectionCoordinatorDelegate {
    func multipleSelectionCoordinator(_ sender: Coordinator, with chosenItemId: [Int]) {
        settingsViewModel.selectEducation(chosenItemId)
    }
}
