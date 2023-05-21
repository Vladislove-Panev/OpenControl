//
//  RegistrationAssembly.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import UIKit

struct RegistrationAssembly {
    static func assembly() -> UIViewController? {
        let view: RegistrationViewInput = RegistrationViewController()
        let model: RegistrationModelInput = RegistrationModel()
        let presenter: RegistrationPresenterInput = RegistrationPresenter(view: view, model: model)
        view.presenter = presenter
        return view as? UIViewController
    }
}
