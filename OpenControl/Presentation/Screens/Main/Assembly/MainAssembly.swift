//  
//  MainAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit

struct MainAssembly {
    static func assembly() -> UIViewController? {
        let view: MainViewInput = MainViewController()
        let userDefaults: UserDefaultsServiceProtocol = UserDefaultsService()
        let model: MainModelInput = MainModel(userDefaults: userDefaults)
        let presenter: MainPresenterInput = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
