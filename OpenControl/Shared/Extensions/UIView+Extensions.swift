//
//  UIView+Extensions.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

extension UIView {
    func dropShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.bounds = bounds
        layer.position = center
    }
    
    func scaleAnimation(duration: Double, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        },
                       completion: { _ in
            UIView.animate(withDuration: duration) {
                self.transform = CGAffineTransform.identity
            }
            completion?()
        })
    }
}
