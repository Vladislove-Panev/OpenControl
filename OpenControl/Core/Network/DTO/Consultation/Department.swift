//
//  Department.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

struct DepartmentDTO: Codable {
    let id: Int
    let name: String
    let departmentUrl: String
    let description: String
    let abbreviation: String
}
