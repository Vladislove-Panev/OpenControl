//
//  RegisterUserResponse.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

struct RegisterUserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let middleName: String
    let mobilePhone: String
    let email: String
    let userType: Int
    let inn: String?
    let snils: String?
    let kpp: String?
    let okveds: String?
    let ditSecurityQuestion: String
    let  ditSecurityAnswer: String
}
