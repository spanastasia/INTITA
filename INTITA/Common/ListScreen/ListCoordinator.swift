//
//  ListItemsCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 16.02.2021.
//

import UIKit

protocol ListCoordinatorDelegate: AnyObject {
    func listViewController(_ sender: Coordinator, didSelectItem: LocalizedResponseProtocol)
}

class ListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var delegate: ListCoordinatorDelegate?
    var listViewModel: ListViewModel
    
    var selectedItem: LocalizedResponseProtocol?
    private let items: [LocalizedResponseProtocol]

    init(navigationController: UINavigationController,
         selectedItem: LocalizedResponseProtocol?,
         items: [LocalizedResponseProtocol])
    {
        self.navigationController = navigationController
        self.selectedItem = selectedItem
        self.items = items
        
        listViewModel = ListViewModel(items: items, selectedItem: selectedItem)
    }

    func start() {
        
        let listViewController = ListViewController.instantiate()
        listViewController.coordinator = self
        listViewController.delegate = self

        listViewController.viewModel = listViewModel

        navigationController.present(listViewController, animated: true)
    }
}

extension ListCoordinator: ListViewControllerDelegate {
    func listViewController(_ sender: UIViewController, didSelectItem: LocalizedResponseProtocol) {
        delegate?.listViewController(self, didSelectItem: didSelectItem)
    }
}
