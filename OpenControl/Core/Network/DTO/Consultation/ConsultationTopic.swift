//
//  ConsultationTopic.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

struct ConsultationTopic: Codable {
    let id: Int
    let topic: String
    let subDepartment: SubDepartmentDTO?
}
