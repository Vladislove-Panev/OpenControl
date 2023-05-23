//  
//  StartModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol StartModelOutput: AnyObject {
    
}

protocol StartModelInput {
    var output: StartModelOutput? { get set }
    func fetchStockData() -> [StockModelProtocol]
}

final class StartModel {
    
    weak var output: StartModelOutput?
    
    private let stockModels: [StockModelProtocol] = [
        StockModel(image: R.image.knoIcon(), subTitle: "Войти как орган контроля", backgroundColor: .white, isShadow: false),
        StockModel(image: R.image.entityIcon(), subTitle: "Войти как бизнес", borderColor: R.color.mainSecondaryColor(), backgroundColor: R.color.startBackgroundColor(), isShadow: true)
    ]
}

extension StartModel: StartModelInput {
    func fetchStockData() -> [StockModelProtocol] {
        stockModels
    }
}
