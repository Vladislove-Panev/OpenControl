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
        let networkManager = URLSessionNetworkManager()
        let service: AuthServiceProtocol = AuthService(networkManager: networkManager)
        let userDefaults: UserDefaultsServiceProtocol = UserDefaultsService()
        let model: AuthRegModelInput = AuthRegModel(validator: validator, service: service, userDefaults: userDefaults)
        let dataConverter = AuthRegDataConverter()
        let presenter: AuthRegPresenterInput = AuthRegPresenter(view: view, model: model, userType: .user, dataConverter: dataConverter)
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        return view as? UIViewController
    }
}
