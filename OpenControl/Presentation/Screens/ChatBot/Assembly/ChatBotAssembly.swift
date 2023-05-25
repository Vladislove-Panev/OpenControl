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
        let model: ChatBotModelInput = ChatBotModel()
        let presenter: ChatBotPresenterInput = ChatBotPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
