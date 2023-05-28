//
//  Consultation.swift
//  OpenControl
//
//  Created by Vladislav Panev on 21.05.2023.
//

import Foundation

struct Consultation: Codable {
    let id: String
    let topic: String?
    let starDateTime: Date?
    let finishDateTime: Date?
    let videoRecordPath: String?
    let otherInformation: String?

    let userId: CLong
    let departmentUserId: CLong?
    let consultationSlotId: String
}
