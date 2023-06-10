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
    
    private var messages: [ChatBotModel.Message] = []
    
    init(view: ChatBotViewInput, model: ChatBotModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        messages.count
    }
    
    func model(for indexPath: IndexPath) -> ChatBotModel.Message {
        messages[indexPath.item]
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension ChatBotPresenter: ChatBotViewOutput {
    func viewDidLoad() {
        model.fetchMessages()
    }
}

extension ChatBotPresenter: ChatBotModelOutput {
    func didSuccessGetGreeting(messages: [ChatBotModel.Message]) {
        self.messages = messages
        view?.updateTableView()
    }
    
    func didFailedGetGreeting(error: Error) {
        print(error.localizedDescription)
    }
}
