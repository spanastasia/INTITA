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
    var multipleSelectionViewModel: MultipleSelectionViewModel?
    
    init(navigationController: UINavigationController,
         item: [LocalizedResponseProtocol],
         selectedItemString: String) {
        self.navigationController = navigationController
        multipleSelectionViewModel = MultipleSelectionViewModel(item: item,
                                                                selectedItemString: selectedItemString)
    }
    
    func start() {
        let multipleSelectionViewController = MultipleSelectionViewController.instantiate()
        multipleSelectionViewController.coordinator = self
        multipleSelectionViewController.viewModel = multipleSelectionViewModel
        navigationController.present(multipleSelectionViewController, animated: true)
        
    }
    
    
}
