//  
//  StartPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol StartPresenterInput {
    init(view: StartViewInput, model: StartModelInput)
    func numberOfRowsInSection(in section: Int) -> Int
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StartPresenter: StartPresenterInput {

    private weak var view: StartViewInput?
    private var model: StartModelInput
    
    init(view: StartViewInput, model: StartModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        model.fetchStockData().count
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        model.fetchStockData()[indexPath.item]
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension StartPresenter: StartViewOutput {
    
}

extension StartPresenter: StartModelOutput {
    
}
