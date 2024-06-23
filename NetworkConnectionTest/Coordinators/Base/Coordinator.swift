//
//  Coordinator.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
    }
}

enum CoordinatorType: Equatable {
    case main
}

