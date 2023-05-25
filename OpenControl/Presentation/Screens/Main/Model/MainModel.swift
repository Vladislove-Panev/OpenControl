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
    func fetchStockData() -> [MainModel.ServiceModel]
}

final class MainModel {
    
    struct ServiceModel {
        enum NavigationItem {
            case consultation, chatBot, answers, experts
        }
        let stockModel: StockModelProtocol
        let navigateTo: NavigationItem
    }
    
    weak var output: MainModelOutput?
    private let stockModels: [ServiceModel] = [
        .init(
            stockModel: StockModel(
                title: "Консультирование".uppercased(),
                subSubTitle: "Записаться на консультацию с сотрудником КНО",
                borderColor: R.color.mainSecondaryColor(),
                backgroundColor: .white,
                isShadow: false
            ),
            navigateTo: .consultation
        ),
        .init(
            stockModel: StockModel(
                title: "Чат бот".uppercased(),
                subSubTitle: "Получить ответ на свой вопрос с помощью электронного помощника",
                borderColor: R.color.buttonTitleColor(),
                backgroundColor: .white,
                isShadow: false
            ),
            navigateTo: .chatBot
        ),
        .init(
            stockModel: StockModel(
                title: "Вопросы и ответы".uppercased(),
                subSubTitle: "Интересные и актуальные вопросы от представителей бизнеса, ответы органов контроля и других предпринимателей",
                borderColor: R.color.buttonTitleColor(),
                backgroundColor: .white,
                isShadow: false
            ),
            navigateTo: .answers
        ),
        .init(
            stockModel: StockModel(
                title: "Список специалистов".uppercased(),
                subSubTitle: "Получите дополнительные консультации и контакты  профильных специалистов (юристы, бухгалтера и др.)",
                borderColor: R.color.buttonTitleColor(),
                backgroundColor: .white,
                isShadow: false
            ),
            navigateTo: .experts
        )
    ]
}

extension MainModel: MainModelInput {
    func fetchStockData() -> [ServiceModel] {
        stockModels
    }
}
