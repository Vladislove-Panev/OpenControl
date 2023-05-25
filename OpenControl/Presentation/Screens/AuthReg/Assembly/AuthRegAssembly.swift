//  
//  AuthRegAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

struct AuthRegAssembly {
    static func assembly() -> UIViewController? {
        let validator = Validator()
        let tableViewManager = AuthRegTableViewManager()
        let view: AuthRegViewInput = AuthRegViewController()
        let model: AuthRegModelInput = AuthRegModel(validator: validator)
        let dataConverter = AuthRegDataConverter()
        let presenter: AuthRegPresenterInput = AuthRegPresenter(view: view, model: model, dataConverter: dataConverter)
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        return view as? UIViewController
    }
}
