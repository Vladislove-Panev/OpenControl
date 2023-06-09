//
//  UserLoginRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct UserLoginRequest: Codable {
    let email: String
    let password: String
}
