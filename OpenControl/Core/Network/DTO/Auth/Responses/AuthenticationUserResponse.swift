//
//  AuthenticationUserResponse.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct AuthenticationUserResponse: Codable {
    let message: String
    let isAuthenticated: Bool
    let userName: String?
    let email: String?
    let roles: String?
    let token: String?
}
