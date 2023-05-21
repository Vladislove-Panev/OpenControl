//
//  RegistrationModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

protocol RegistrationModelOutput: AnyObject {
    
}

protocol RegistrationModelInput {
    var output: RegistrationModelOutput? { get set }
}

final class RegistrationModel {
    
    weak var output: RegistrationModelOutput?
}

extension RegistrationModel: RegistrationModelInput {
    
}
