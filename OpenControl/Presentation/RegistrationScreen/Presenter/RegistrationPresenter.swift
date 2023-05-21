//
//  RegistrationPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

protocol RegistrationPresenterInput {
    init(view: RegistrationViewInput, model: RegistrationModelInput)
}

final class RegistrationPresenter: RegistrationPresenterInput {
    
    private weak var view: RegistrationViewInput?
    private var model: RegistrationModelInput
    
    init(view: RegistrationViewInput, model: RegistrationModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension RegistrationPresenter: RegistrationViewOutput {
    
}

extension RegistrationPresenter: RegistrationModelOutput {
    
}
