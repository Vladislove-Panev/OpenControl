//  
//  MainPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import Foundation

protocol MainPresenterInput {
    init(view: MainViewInput, model: MainModelInput)
    func numberOfRowsInSection(in section: Int) -> Int
    func model(for indexPath: IndexPath) -> MainModel.ServiceModel
}

final class MainPresenter: MainPresenterInput {
    
    private weak var view: MainViewInput?
    private var model: MainModelInput
    
    init(view: MainViewInput, model: MainModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        model.fetchStockData().count
    }
    
    func model(for indexPath: IndexPath) -> MainModel.ServiceModel {
        model.fetchStockData()[indexPath.item]
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension MainPresenter: MainViewOutput {
    func viewDidLoad() {
        if let regData = model.fetchUserRegData() {
            if regData.middleName.isEmpty {
                view?.setupHeader(with: "\(regData.lastName) \(regData.firstName)")
            } else {
                view?.setupHeader(with: "\(regData.firstName) \(regData.middleName)")
            }
        } else if let authData = model.fetchUserAuthData(),
                  let userName = authData.userName {
            view?.setupHeader(with: userName)
        }
    }
}

extension MainPresenter: MainModelOutput {
    
}
