//  
//  ChatBotPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import Foundation

protocol ChatBotPresenterInput {
    init(view: ChatBotViewInput, model: ChatBotModelInput)
    func numberOfRowsInSection(in section: Int) -> Int
    func model(for indexPath: IndexPath) -> ChatBotModel.Message
}

final class ChatBotPresenter: ChatBotPresenterInput {
    
    private weak var view: ChatBotViewInput?
    private var model: ChatBotModelInput
    
    init(view: ChatBotViewInput, model: ChatBotModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        model.fetchMessages().count
    }
    
    func model(for indexPath: IndexPath) -> ChatBotModel.Message {
        model.fetchMessages()[indexPath.item]
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension ChatBotPresenter: ChatBotViewOutput {
    
}

extension ChatBotPresenter: ChatBotModelOutput {
    
}
