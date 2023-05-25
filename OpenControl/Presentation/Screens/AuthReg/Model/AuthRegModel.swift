//  
//  AuthRegModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol AuthRegModelOutput: AnyObject {
    
}

protocol AuthRegModelInput {
    var output: AuthRegModelOutput? { get set }
    func fetchAuthData() -> [AuthRegData]
    func fetchRegData() -> [AuthRegData]
    func isValid(_ text: String, type: AuthRegData.PlaceholderType) -> Bool
}

final class AuthRegModel {
    
    weak var output: AuthRegModelOutput?
    
    private let validator: Validatable

    private let authData = [AuthRegData(title: nil, placeholders: [
        .init(text: "Телефон / Эл.почта", isPassword: false, showPassIcon: false, type: .none),
        .init(text: "Пароль", isPassword: true, showPassIcon: false, type: .none)
    ])]
    
    private let regData = [
        AuthRegData(title: nil, placeholders: [
            .init(text: "Фамилия", isPassword: false, showPassIcon: false, type: .surname),
            .init(text: "Имя", isPassword: false, showPassIcon: false, type: .name),
            .init(text: "Отчество", isPassword: false, showPassIcon: false, type: .middlename)
        ]),
        AuthRegData(title: "Контактные данные", placeholders: [
            .init(text: "Мобильный телефон", isPassword: false, showPassIcon: false, type: .phone),
            .init(text: "Электронная почта", isPassword: false, showPassIcon: false, type: .mail)
        ]),
        AuthRegData(title: "Безопасность", placeholders: [
            .init(text: "Пароль", isPassword: true, showPassIcon: true, type: .pass),
            .init(text: "Повторить пароль", isPassword: true, showPassIcon: true, type: .repeatPass)
        ])
    ]
    
    private var firstEnteredPass = ""
    
    init(validator: Validatable, output: AuthRegModelOutput? = nil) {
        self.output = output
        self.validator = validator
    }
}

extension AuthRegModel: AuthRegModelInput {
    func isValid(_ text: String, type: AuthRegData.PlaceholderType) -> Bool {
        switch type {
        case .name:
            return validator.isTextValid(text)
        case .surname:
            return validator.isTextValid(text)
        case .middlename:
            break
        case .phone:
            return validator.isPhoneValid(text)
        case .mail:
            return validator.isEmailValid(text)
        case .pass:
            firstEnteredPass = text
            return validator.isPasswordValid(text)
        case .repeatPass:
            return validator.isPasswordValid(text) || text == firstEnteredPass
        case .mailOrPhone:
            break
        case .none:
            break
        }
        return true
    }
    
    func fetchRegData() -> [AuthRegData] {
        regData
    }
    
    func fetchAuthData() -> [AuthRegData] {
        authData
    }
}
