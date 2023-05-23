//
//  StockModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol StockModelProtocol {
    var image: UIImage? { get }
    var title: String? { get }
    var subTitle: String? { get }
    var subSubTitle: String? { get }
    var borderColor: UIColor? { get }
    var backgroundColor: UIColor? { get }
    var isShadow: Bool { get }
}

struct StockModel: StockModelProtocol {
    
    var image: UIImage?
    var title: String?
    var subTitle: String?
    var subSubTitle: String?
    var borderColor: UIColor?
    
    var backgroundColor: UIColor?
    var isShadow: Bool
}
