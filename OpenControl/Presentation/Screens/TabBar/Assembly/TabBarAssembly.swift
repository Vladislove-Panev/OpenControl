//  
//  TabBarAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import UIKit

struct TabBarAssembly {
    static func assembly() -> UIViewController? {
        let view: TabBarViewInput = TabBarController()
        let model: TabBarModelInput = TabBarModel()
        let presenter: TabBarPresenterInput = TabBarPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
