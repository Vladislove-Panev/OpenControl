//
//  SubDepartment.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

struct SubDepartmentDTO: Codable {
    let id: Int
    let name: String
    let subDepartmentUrl: String
    let subDepartmentDescription: String
    let department: DepartmentDTO?
}
