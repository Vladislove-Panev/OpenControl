//
//  AuthRegData.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import Foundation

struct AuthRegData {
    
    enum PlaceholderType: Int {
        case name = 10, surname, middlename, phone, mail, pass, repeatPass, mailOrPhone, none
    }
    
    struct Placeholder {
        
        let text: String
        let isPassword: Bool
        let showPassIcon: Bool
        let type: PlaceholderType
    }
    
    let title: String?
    let placeholders: [Placeholder]
}
