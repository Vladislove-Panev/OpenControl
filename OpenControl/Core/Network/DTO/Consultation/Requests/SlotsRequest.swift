//
//  SlotsRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct SlotsRequest: Codable {
    let slotDate: Date
    let subDepartmentId: Int?
}
