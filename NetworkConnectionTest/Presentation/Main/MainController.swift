//
//  MainController.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((Event)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var connectionStatusView: ConnectionView!

    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureConnectionStatusView()
        configureConstraints()
    }
    
    private func configureConnectionStatusView() {
        connectionStatusView = ConnectionView(viewModel: MainViewModel())
        connectionStatusView.statusCallback = { [weak self] status in
            guard let self else { return }
            self.didSendEventClosure?(.showAlert(status))
        }
    }
    
    private func configureConstraints() {
        view.addSubview(connectionStatusView)
        
        connectionStatusView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - EXTENSIONS
extension MainController {
    enum Event {
        case showAlert(ConnectionType)
    }
}

