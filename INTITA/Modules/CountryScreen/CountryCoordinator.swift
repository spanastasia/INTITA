//
//  CountryCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

protocol CountryCoordinatorDelegate: AnyObject {
    func countryViewController(_ sender: Coordinator, editingUser: EditingUser)
}

class CountryCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var delegate: CountryCoordinatorDelegate?
    
    var existingUser: CurrentUser
    var choosedItem: ChoosedItem?
    var selectedCountry: CountryModel?
    private let items: [LocalizedResponseProtocol]

    init(navigationController: UINavigationController, existingUser: CurrentUser, items: [LocalizedResponseProtocol]) {
        self.navigationController = navigationController
        self.existingUser = existingUser
        self.items = items
    }

    func start() {
        
        let countryViewController = CountryViewController.instantiate()
        countryViewController.coordinator = self
        countryViewController.delegate = self

        let countryViewModel = ListViewModel(items: items)
        countryViewModel.choosedItem = choosedItem
        countryViewController.viewModel = countryViewModel

        navigationController.present(countryViewController, animated: true)
    }

}

extension CountryCoordinator: CountryViewControllerDelegate {
    func countryViewController(_ sender: UIViewController, editingUser: EditingUser) {
        delegate?.countryViewController(self, editingUser: editingUser)
    }
}
