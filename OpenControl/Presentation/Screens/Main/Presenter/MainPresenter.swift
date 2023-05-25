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
    func model(for indexPath: IndexPath) -> StockModelProtocol
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
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        model.fetchStockData()[indexPath.item]
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension MainPresenter: MainViewOutput {
    
}

extension MainPresenter: MainModelOutput {
    
}
