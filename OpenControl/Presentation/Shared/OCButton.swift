//
//  OCButton.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

class OCButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -40, dy: -40).contains(point)
    }
}
