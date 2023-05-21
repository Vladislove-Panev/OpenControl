//
//  RegisterUserRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct RegisterUserRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let mobilePhone: String
    let password: String
    let repeatPassword: String
    let ditSecurityQuestion: String?
    let ditSecurityAnswer: String?
    let middleName: String?
}
