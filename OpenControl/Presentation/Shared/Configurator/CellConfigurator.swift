//
//  CellConfigurator.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

protocol CellConfigurator {
    
    static var reuseId: String { get }
    
    func configure(cell: UIView)
    func associatedValue<T>() -> T?
}

protocol TableCellConfiguratorProtocol: CellConfigurator {
    var cellHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
}

protocol CollectionCellConfiguratorProtocol: CellConfigurator {
    var size: CGSize { get }
}
