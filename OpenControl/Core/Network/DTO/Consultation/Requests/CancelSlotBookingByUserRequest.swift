//
//  CancelSlotBookingByUserRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct CancelSlotBookingByUserRequest: Codable {
    let slotId: Int
    let userId: CLong
}
