//
//  RegistrationViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import UIKit

protocol RegistrationViewInput: AnyObject {
    var presenter: RegistrationPresenterInput? { get set }
    var output: RegistrationViewOutput? { get set }
}

protocol RegistrationViewOutput: AnyObject {
    
}

final class RegistrationViewController: UIViewController {
    
    weak var output: RegistrationViewOutput?
    var presenter: RegistrationPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

extension RegistrationViewController: RegistrationViewInput {
    
}
