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
    
    func showCountryScreen() {
        let countryScreen = CountryCoordinator(navigationController: navigationController,
                                               selectedCountry: settingsViewModel.selectedCountry)
        countryScreen.delegate = self
        countryScreen.start()
    }
}

extension SettingsProfileCoordinator: CountryCoordinatorDelegate {
    
    func countryViewController(_ sender: Coordinator, didSelectCountry country: CountryModel) {
        settingsViewModel.selectCountry(country)
    }
    
}
