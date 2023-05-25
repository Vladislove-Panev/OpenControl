//  
//  MainModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import Foundation

protocol MainModelOutput: AnyObject {
    
}

protocol MainModelInput {
    var output: MainModelOutput? { get set }
    func fetchStockData() -> [StockModelProtocol]
}

final class MainModel {
    
    weak var output: MainModelOutput?
    private let stockModels: [StockModelProtocol] = [
        StockModel(
            title: "Консультирование".uppercased(),
            subSubTitle: "Записаться на консультацию с сотрудником КНО",
            borderColor: R.color.mainSecondaryColor(),
            backgroundColor: .white,
            isShadow: false
        ),
        StockModel(
            title: "Чат бот".uppercased(),
            subSubTitle: "Получить ответ на свой вопрос с помощью электронного помощника",
            borderColor: R.color.buttonTitleColor(),
            backgroundColor: .white,
            isShadow: false
        ),
        StockModel(
            title: "Вопросы и ответы".uppercased(),
            subSubTitle: "Интересные и актуальные вопросы от представителей бизнеса, ответы органов контроля и других предпринимателей",
            borderColor: R.color.buttonTitleColor(),
            backgroundColor: .white,
            isShadow: false
        ),
        StockModel(
            title: "Список специалистов".uppercased(),
            subSubTitle: "Получите дополнительные консультации и контакты  профильных специалистов (юристы, бухгалтера и др.)",
            borderColor: R.color.buttonTitleColor(),
            backgroundColor: .white,
            isShadow: false
        )
    ]
}

extension MainModel: MainModelInput {
    func fetchStockData() -> [StockModelProtocol] {
        stockModels
    }
}
