//
//  OCTextField.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

class OCTextField: UITextField {
    
    var insetX: CGFloat = 10
    var insetY: CGFloat = 10

    // placeholder position
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.insetX , dy: self.insetY)
    }

    // text position
    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.insetX , dy: self.insetY)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.insetX, dy: self.insetY)
    }
}

extension OCTextField: ErrorPresentable {
    func showError() {
        layer.borderWidth = 1.5
        layer.borderColor = R.color.mainSecondaryColor()?.cgColor
    }

    func hideError() {
        layer.borderWidth = 0
    }
}
