//
//  MainViewModel.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import Foundation
import Combine
import Network

protocol MainViewModelProtocol: AnyObject {
    var connectionType: ConnectionType { get set }
}

final class MainViewModel: MainViewModelProtocol {
    
    //MARK: - PUBLIC PROPERTIES
    @Published var connectionType: ConnectionType = .unknown
    var subscriptions: Set<AnyCancellable> = []
    
    // MARK: INIT
    init() {
        checkConnectionStatus()
    }
    
    //MARK: - PRIVATE METHODS
    private func checkConnectionStatus() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.setConnectionPathStatus(for: path)
        }
        
        let queue = DispatchQueue(label: "Connection")
        monitor.start(queue: queue)
    }
    
    func setConnectionPathStatus(for status: NWPath) {
        switch status.status {
        case .satisfied:
            connectionType = .connected
        case .unsatisfied:
            connectionType = .notConnected
        case .requiresConnection:
            connectionType = .unknown
        @unknown default:
            connectionType = .unknown
        }
    }
    
}
