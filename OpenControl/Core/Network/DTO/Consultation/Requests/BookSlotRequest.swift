//
//  BookSlotRequest.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct BookSlotRequest: Codable {
    let topic: String
    let userId: CLong
    let consultationSlotId: String
}
