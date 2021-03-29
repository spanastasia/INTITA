//
//  BirthdayCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 29.03.2021.
//

import UIKit

protocol BirthdayCoordinatorDelegate: AnyObject {
    func birthdayCoordinator(_ sender: Coordinator, didSelectDay: String)
}

class  BirthdayCoordinator: Coordinator {
    
    weak var delegate: BirthdayCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let birthdayViewModel: BirthdayViewModel?

    init(navigationController: UINavigationController, selectedDate: String) {
        self.navigationController = navigationController
        
        birthdayViewModel = BirthdayViewModel(selectedDate: selectedDate)
    }

    func start() {
        
        let birthdayViewController = BirthdayViewController.instantiate()
        birthdayViewController.coordinator = self
        birthdayViewController.viewModel = birthdayViewModel

        navigationController.present(birthdayViewController, animated: true)
    }
    
    func returnToSettingsScreen() {
        delegate?.birthdayCoordinator(self, didSelectDay: birthdayViewModel?.selectedDate ?? "")
        navigationController.dismiss(animated: true)
    }
}
