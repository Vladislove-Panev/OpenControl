//
//  Validator.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol Validatable {
    func isTextValid(_ text : String) -> Bool
    func isEmailValid(_ emailString: String?) -> Bool
    func isPasswordValid(_ passwordString: String?) -> Bool
    func isPhoneValid(_ phoneString: String?) -> Bool
}

final class Validator: Validatable {
    
    func isTextValid(_ text : String) -> Bool {
        let regex = "^[a-zA-Zа-яА-Я]{2,24}$"
        let textTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return textTest.evaluate(with: text)
    }

    func isEmailValid(_ emailString: String?) -> Bool {
        guard let emailString = emailString else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
    func isPasswordValid(_ passwordString: String?) -> Bool {
        guard let passwordString = passwordString else { return false }
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: passwordString)
    }
    
    func isPhoneValid(_ phoneString: String?) -> Bool {
        guard var phoneString = phoneString else { return false }
        if phoneString.first == "+" {
            phoneString = String(phoneString.dropFirst())
        }
        let phoneRegEx = "^\\d{11}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: phoneString)
    }
}
