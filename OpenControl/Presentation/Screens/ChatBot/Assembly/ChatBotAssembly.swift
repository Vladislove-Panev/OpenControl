//  
//  ChatBotAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit

struct ChatBotAssembly {
    static func assembly() -> UIViewController? {
        let view: ChatBotViewInput = ChatBotViewController()
        let networkManager = URLSessionNetworkManager()
        let chatBotService = ChatBotService(networkManager: networkManager)
        let model: ChatBotModelInput = ChatBotModel(chatBotService: chatBotService, userDefaultsService: UserDefaultsService())
        let presenter: ChatBotPresenterInput = ChatBotPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
