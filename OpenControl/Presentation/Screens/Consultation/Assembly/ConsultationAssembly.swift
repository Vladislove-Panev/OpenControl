//  
//  ConsultationAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import UIKit

struct ConsultationAssembly {
    static func assembly() -> UIViewController? {
        let view: ConsultationViewInput = ConsultationViewController()
        let networkManager: NetworkManager = URLSessionNetworkManager()
        let service: ConsultationServiceProtocol = ConsultationService(networkManager: networkManager)
        let userDefaults: UserDefaultsServiceProtocol = UserDefaultsService()
        let model: ConsultationModelInput = ConsultationModel(service: service, userDefaults: userDefaults)
        let presenter: ConsultationPresenterInput = ConsultationPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
