//
//  CountryCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

protocol CountryCoordinatorDelegate: AnyObject {
    func countryViewController(_ sender: Coordinator, didSelectCountry country: CountryModel)
}

class CountryCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var delegate: CountryCoordinatorDelegate?
    
    var selectedCountry: CountryModel?

    init(navigationController: UINavigationController, selectedCountry: CountryModel?) {
        self.navigationController = navigationController
        self.selectedCountry = selectedCountry
    }

    func start() {
        
        let countryViewController = CountryViewController.instantiate()
        countryViewController.coordinator = self
        countryViewController.delegate = self
        
        let countryViewModel = CountryViewModel(selectedCountry: selectedCountry)
        countryViewController.viewModel = countryViewModel

        navigationController.present(countryViewController, animated: true)
    }

}

extension CountryCoordinator: CountryViewControllerDelegate {
    func countryViewController(_ sender: UIViewController, didSelectCountry country: CountryModel) {
        delegate?.countryViewController(self, didSelectCountry: country)
    }
}
