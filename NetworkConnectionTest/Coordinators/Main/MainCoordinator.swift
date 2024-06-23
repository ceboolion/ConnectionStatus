//
//  MainCoordinator.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    
    //MARK: - PUBLIC PROPERTIES
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    
    // MARK: - INITIALIZER
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        start()
    }
    
    //MARK: - PUBLIC METHODS
    func start() {
        let controller = MainController()
        controller.didSendEventClosure = { [weak self] event in
            guard let self else { return }
            switch event {
            case .showAlert(let connectionStatus):
                showAlertFor(connectionStatus: connectionStatus)
            }
        }
        setMainController(with: controller)
    }
    
    //MARK: - PRIVATE METHODS
    private func showAlertFor(connectionStatus: ConnectionType) {
        let alertController = UIAlertController(title: "Connection unavailable", message: "Internet connection has been lost", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        if connectionStatus == .notConnected {
            presentOnTopController(alertController)
        }
    }
    
    private func setMainController(with controller: UIViewController) {
        navigationController.setViewControllers([controller], animated: false)
    }
    
    private func presentOnTopController(_ controller: UIViewController) {
        navigationController.topViewController?.present(controller, animated: true)
    }
}
