//
//  UITextField+Extension.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

extension UITextField {
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc private func togglePasswordView(_ sender: Any) {
        
        self.becomeFirstResponder()
        self.isSecureTextEntry = !self.isSecureTextEntry
        
        if let existingText = text, isSecureTextEntry {
            deleteBackward()
            
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
        
        setPasswordToggleImage(sender as? UIButton)
    }
    
    private func setPasswordToggleImage(_ button: UIButton?) {
        if(isSecureTextEntry){
            button?.setImage(R.image.closedEye(), for: .normal)
        } else {
            button?.setImage(R.image.closedEye(), for: .normal)
        }
    }
}
