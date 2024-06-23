//
//  ConnectionType.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import UIKit

enum ConnectionType {
    case connected
    case notConnected
    case unknown
    
    var title: String {
        switch self {
        case .connected:
            "Connection available"
        case .notConnected:
            "Connection not available"
        case .unknown:
            "Checking connection"
        }
    }
    
    var color: UIColor {
        switch self {
        case .connected:
                .green
        case .notConnected:
                .red
        case .unknown:
                .systemBackground
        }
    }
}
