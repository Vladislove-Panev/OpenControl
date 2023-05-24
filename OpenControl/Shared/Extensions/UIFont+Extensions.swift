//
//  UIFont+Extensions.swift
//  OpenControl
//
//  Created by Vladislav Panev on 24.05.2023.
//

import UIKit


//Family: Inter Font names: ["Inter-Regular", "Inter-Thin", "Inter-ThinItalic", "Inter-ExtraLight", "Inter-ExtraLightItalic", "Inter-Medium", "Inter-MediumItalic", "Inter-SemiBold", "Inter-SemiBoldItalic", "Inter-Bold", "Inter-BoldItalic", "Inter-ExtraBold", "Inter-ExtraBoldItalic", "Inter-Black", "Inter-BlackItalic"]

extension UIFont {
    static func interRegular400(with size: CGFloat) -> UIFont? {
        UIFont(name: "Inter-Regular", size: size)
    }
}
