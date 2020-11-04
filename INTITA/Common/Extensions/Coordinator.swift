//
//  Coordinator.swift
//  INTITA
//
//  Created by Viacheslav Markov on 30.10.2020.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
