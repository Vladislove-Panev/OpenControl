//  
//  AuthRegModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol AuthRegModelOutput: AnyObject {
    func authEnteredDataUpdated(_ data: AuthRegModel.AuthEnteredData?)
    func regEnteredDataUpdated(_ data: AuthRegModel.RegEnteredData?)
    func didSuccessRegisterUser(with data: RegisterUserResponse)
    func didFailedRegisterUser(with error: Error)
    func didSuccessAuthUser(with data: AuthenticationUserResponse)
    func didFailedAuthUser(with error: Error)
}

protocol AuthRegModelInput {
    var output: AuthRegModelOutput? { get set }
    var regUserEnteredData: AuthRegModel.RegEnteredData? { get }
    func fetchAuthData() -> [AuthRegData]
    func fetchRegData() -> [AuthRegData]
    func registerUser()
    func authUser(with type: UserType)
    func isValid(_ text: String, type: AuthRegData.PlaceholderType) -> Bool
}

final class AuthRegModel {
    
    weak var output: AuthRegModelOutput?
    
    private let validator: Validatable
    private let service: AuthServiceProtocol
    private let userDefaults: UserDefaultsServiceProtocol
    
    struct AuthEnteredData {
        let phoneOrMail: (value: String, isValid: Bool)
        let password: (value: String, isValid: Bool)
        
        var isValid: Bool {
            get {
                phoneOrMail.isValid && password.isValid
            }
        }
    }
    
    struct RegEnteredData {
        let name: (value: String, isValid: Bool)
        let surname: (value: String, isValid: Bool)
        let middlename: String
        let phone: (value: String, isValid: Bool)
        let mail: (value: String, isValid: Bool)
        let password: (value: String, isValid: Bool)
        let repeatedPassword: (value: String, isValid: Bool)
        
        var isValid: Bool {
            get {
                name.isValid && surname.isValid && phone.isValid &&
                mail.isValid && password.isValid && repeatedPassword.isValid
            }
        }
    }

    private let authData = [AuthRegData(title: nil, placeholders: [
        .init(text: "Телефон / Эл.почта", isPassword: false, showPassIcon: false, type: .mailOrPhone),
        .init(text: "Пароль", isPassword: true, showPassIcon: false, type: .authPass)
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
    
    private(set) var authUserEnteredData: AuthEnteredData? {
        willSet {
            output?.authEnteredDataUpdated(newValue)
        }
    }
    
    private(set) var regUserEnteredData: RegEnteredData? {
        willSet {
            output?.regEnteredDataUpdated(newValue)
        }
    }
    
    private var firstEnteredPass = ""
    
    init(
        validator: Validatable,
        service: AuthServiceProtocol,
        userDefaults: UserDefaultsServiceProtocol,
        output: AuthRegModelOutput? = nil
    ) {
        self.output = output
        self.validator = validator
        self.service = service
        self.userDefaults = userDefaults
    }
}

extension AuthRegModel: AuthRegModelInput {
    func registerUser() {
        guard let regUserEnteredData = regUserEnteredData,
              regUserEnteredData.isValid else {
            output?.didFailedRegisterUser(with: NSError(domain: "1", code: 0))
            return
        }
        service.register(
            .init(
                firstName: regUserEnteredData.name.value,
                lastName: regUserEnteredData.surname.value,
                email: regUserEnteredData.mail.value,
                mobilePhone: regUserEnteredData.phone.value,
                password: regUserEnteredData.password.value,
                repeatPassword: regUserEnteredData.repeatedPassword.value,
                ditSecurityQuestion: nil,
                ditSecurityAnswer: nil,
                middleName: regUserEnteredData.middlename
            )) { [weak self] result in
                switch result {
                case .success(let data):
                    try? self?.userDefaults.set(object: data, forKey: .userRegData)
                    self?.output?.didSuccessRegisterUser(with: data)
                case .failure(let error):
                    self?.output?.didFailedRegisterUser(with: error)
                }
            }
    }
    
    func authUser(with type: UserType) {
        guard let authUserEnteredData = authUserEnteredData,
              authUserEnteredData.isValid else {
            output?.didFailedAuthUser(with: NSError(domain: "1", code: 0))
            return
        }
        
        service.auth(
            .init(
                email: authUserEnteredData.phoneOrMail.value,
                password: authUserEnteredData.password.value
            ),
            userType: type) { [weak self] result in
                switch result {
                case .success(let data):
                    if data.isAuthenticated {
                        try? self?.userDefaults.set(object: data, forKey: .userAuthData)
                        self?.output?.didSuccessAuthUser(with: data)
                    } else {
                        self?.output?.didFailedAuthUser(
                            with: NSError(domain: "1", code: 1, userInfo: [NSLocalizedDescriptionKey: data.message])
                        )
                    }
                case .failure(let error):
                    self?.output?.didFailedAuthUser(with: error)
                }
            }
    }
    
    func isValid(_ text: String, type: AuthRegData.PlaceholderType) -> Bool {
        switch type {
        case .name:
            let oldValue = regUserEnteredData
            let isValid = validator.isTextValid(text)
            let newValue = RegEnteredData(
                name: (text, isValid),
                surname: oldValue?.surname ?? ("", false),
                middlename: oldValue?.middlename ?? "",
                phone: oldValue?.phone ?? ("", false),
                mail: oldValue?.mail ?? ("", false),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return isValid
        case .surname:
            let oldValue = regUserEnteredData
            let isValid = validator.isTextValid(text)
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: (text, isValid),
                middlename: oldValue?.middlename ?? "",
                phone: oldValue?.phone ?? ("", false),
                mail: oldValue?.mail ?? ("", false),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return isValid
        case .middlename:
            let oldValue = regUserEnteredData
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: oldValue?.surname ?? ("", false),
                middlename: text,
                phone: oldValue?.phone ?? ("", false),
                mail: oldValue?.mail ?? ("", false),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return true
        case .phone:
            let oldValue = regUserEnteredData
            let isValid = validator.isPhoneValid(text)
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: oldValue?.surname ?? ("", false),
                middlename: oldValue?.middlename ?? "",
                phone: (text, isValid),
                mail: oldValue?.mail ?? ("", false),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return isValid
        case .mail:
            let oldValue = regUserEnteredData
            let isValid = validator.isEmailValid(text)
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: oldValue?.surname ?? ("", false),
                middlename: oldValue?.middlename ?? "",
                phone: oldValue?.phone ?? ("", false),
                mail: (text, isValid),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return isValid
        case .pass:
            firstEnteredPass = text
            let oldValue = regUserEnteredData
            let isValid = validator.isPasswordValid(text)
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: oldValue?.surname ?? ("", false),
                middlename: oldValue?.middlename ?? "",
                phone: oldValue?.phone ?? ("", false),
                mail: oldValue?.mail ?? ("", false),
                password: (text, isValid),
                repeatedPassword: oldValue?.repeatedPassword ?? ("", false)
            )
            regUserEnteredData = newValue
            return isValid
        case .repeatPass:
            let oldValue = regUserEnteredData
            let isValid = validator.isPasswordValid(text) || text == firstEnteredPass
            let newValue = RegEnteredData(
                name: oldValue?.name ?? ("", false),
                surname: oldValue?.surname ?? ("", false),
                middlename: oldValue?.middlename ?? "",
                phone: oldValue?.phone ?? ("", false),
                mail: oldValue?.mail ?? ("", false),
                password: oldValue?.password ?? ("", false),
                repeatedPassword: (text, isValid)
            )
            regUserEnteredData = newValue
            return isValid
        case .mailOrPhone:
            let oldValue = authUserEnteredData
            let isValid = !text.isEmpty
            let newValue = AuthEnteredData(
                phoneOrMail: (text, isValid),
                password: oldValue?.password ?? ("", false)
            )
            authUserEnteredData = newValue
            return true
        case .authPass:
            let oldValue = authUserEnteredData
            let isValid = !text.isEmpty
            let newValue = AuthEnteredData(
                phoneOrMail: oldValue?.phoneOrMail ?? ("", false),
                password: (text, isValid)
            )
            authUserEnteredData = newValue
            return true
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
