//
//  ConnectionView.swift
//  NetworkConnectionTest
//
//  Created by Roman on 23/06/2024.
//

import UIKit
import SnapKit

class ConnectionView: UIView {
    
    //MARK: - PUBLIC PROPERTIES
    var statusCallback: ((ConnectionType)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel: MainViewModel
    private var textLabel: UILabel!
    
    // MARK: INIT
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureTextLabel()
        configureConstraints()
    }
    
    private func configureTextLabel() {
        textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 20)
    }
    
    private func configureConstraints() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //MARK: - Combine
    private func setupObservers() {
        bindTextLabel()
        bindBackgroundColor()
        bindConnectionTypeStatus()
    }
    
    private func bindTextLabel() {
        viewModel.$connectionType
            .receive(on: DispatchQueue.main)
            .compactMap { $0.title }
            .assign(to: \.text, on: textLabel)
            .store(in: &viewModel.subscriptions)
    }
    
    private func bindBackgroundColor() {
        viewModel.$connectionType
            .receive(on: DispatchQueue.main)
            .compactMap { $0.color }
            .assign(to: \.backgroundColor, on: self)
            .store(in: &viewModel.subscriptions)
    }
    
    private func bindConnectionTypeStatus() {
        viewModel.$connectionType
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] status in
                if status == .notConnected {
                    self?.statusCallback?(.notConnected)
                }
            }
            .store(in: &viewModel.subscriptions)
    }
}
