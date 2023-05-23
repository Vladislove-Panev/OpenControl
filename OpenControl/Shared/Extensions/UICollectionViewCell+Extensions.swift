//
//  UITableViewCell+Extensions.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
