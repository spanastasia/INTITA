//
//  MultipleSelectionCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

class MultipleSelectionCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let multipleSelectionViewController = MultipleSelectionViewController.instantiate()
        navigationController.present(multipleSelectionViewController, animated: true)
    }
    
    
}
