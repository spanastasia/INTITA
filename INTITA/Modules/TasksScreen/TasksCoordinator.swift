//
//  TasksCoordinator.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 25.12.2020.
//

import UIKit

//protocol ProfileCoordinatorAlertPresenter: AnyObject {
//    func showAlert()
//}
//
class TasksCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
//    weak var alertPresenter: ProfileCoordinatorAlertPresenter?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TasksViewController.instantiate()
        let viewModel = TasksViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
//        alertPresenter = vc
        navigationController.pushViewController(vc, animated: false)
    }

    func showProfileScreen() {
        navigationController.popViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}
//
//extension ProfileCoordinator: ProfileTableViewCellDelegate {
//    func goToVC(number: Int) {
//        guard number < childCoordinators.count else {
//            alertPresenter?.showAlert()
//            return
//        }
//        childCoordinators[number].start()
//    }
//}
