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
    func fetchStockData() -> [StartModel.ServiceModel]
}

final class StartModel {
    
    struct ServiceModel {
        enum NavigationItem {
            case kno, entity
        }
        let stockModel: StockModelProtocol
        let navigateTo: NavigationItem
    }
    
    weak var output: StartModelOutput?
    
    private let stockModels: [ServiceModel] = [
        .init(
            stockModel: StockModel(
                image: R.image.knoIcon(),
                subTitle: "Войти как орган контроля",
                backgroundColor: .white,
                isShadow: false
            ),
            navigateTo: .kno
        ),
        .init(
            stockModel: StockModel(
                image: R.image.entityIcon(),
                subTitle: "Войти как бизнес",
                borderColor: R.color.mainSecondaryColor(),
                backgroundColor: R.color.startBackgroundColor(),
                isShadow: true
            ),
            navigateTo: .entity
        )
    ]
}

extension StartModel: StartModelInput {
    func fetchStockData() -> [StartModel.ServiceModel] {
        stockModels
    }
}
