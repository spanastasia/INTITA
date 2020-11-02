//
//  MainCoordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 30.10.2020.
//

import Foundation
import UIKit

class WelcomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = WelcomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displayLogin() {
        // TODO: add functionality..
        
        // let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        //TODO for START/> btn below
        // loginCoordinator.start() or childCoordinators[0].start()
        
    }
}
