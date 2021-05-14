//
//  MultipleSelectionCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

protocol  MultipleSelectionCoordinatorDelegate: AnyObject {
    func multipleSelectionCoordinator(_ sender: Coordinator, with chosenItemId: [Int])
}

class MultipleSelectionCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var multipleSelectionViewModel: MultipleSelectionViewModel?
    weak var delegate: MultipleSelectionCoordinatorDelegate?
    
    init(
        navigationController: UINavigationController,
        item: [LocalizedResponseProtocol],
        selectedItem: [Int]
    ) {
        self.navigationController = navigationController
        multipleSelectionViewModel = MultipleSelectionViewModel(item: item,
                                                                selectedItem: selectedItem)
    }
    
    func start() {
        let multipleSelectionViewController = MultipleSelectionViewController.instantiate()
        multipleSelectionViewController.coordinator = self
        multipleSelectionViewController.delegate = self
        multipleSelectionViewController.viewModel = multipleSelectionViewModel
        navigationController.present(multipleSelectionViewController, animated: true)
    }
}

extension MultipleSelectionCoordinator: MultipleSelectionViewControllerDelegate {
    func multipleSelectionViewController(_ sender: UIViewController, with chosenItemId: [Int]) {
        delegate?.multipleSelectionCoordinator(self, with: chosenItemId)
    }
}
