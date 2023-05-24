//  
//  TabBarPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import Foundation

protocol TabBarPresenterInput {
    init(view: TabBarViewInput, model: TabBarModelInput)
}

final class TabBarPresenter: TabBarPresenterInput {
    
    private weak var view: TabBarViewInput?
    private var model: TabBarModelInput
    
    init(view: TabBarViewInput, model: TabBarModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension TabBarPresenter: TabBarViewOutput {
    func viewWillAppear() {
        view?.set(controllers: model.controllers)
    }
}

extension TabBarPresenter: TabBarModelOutput {
    
}
