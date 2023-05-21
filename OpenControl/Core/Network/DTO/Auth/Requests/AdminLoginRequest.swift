//
//  AdminLoginRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct AdminLoginRequest: Codable {
    let userName: String
    let password: String
}
