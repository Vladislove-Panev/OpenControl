//  
//  StartAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

struct StartAssembly {
    static func assembly() -> UIViewController? {
        let view: StartViewInput = StartViewController()
        let model: StartModelInput = StartModel()
        let presenter: StartPresenterInput = StartPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
