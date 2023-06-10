//
//  ChatBotService.swift
//  OpenControl
//
//  Created by Vladislav Panev on 09.06.2023.
//

import Foundation

final class ChatBotService {
    
    struct ChatBotHandleData: Codable {
        enum ChatBotMessageResponseType: Int, Codable {
            case request,
                 greeting, // нулевой шаг, просто приветствие
                 step1RequirementDto, // первый шаг, если нашлось требование
                 step1SubDepartmentDto, // первый шаг, если нашелся департамент
                 step1LegalActDto, // первый шаг, если нашелся НПА
                 step1WrongRequest, // первый шаг, если никаких совпадений по ключевым полям нет
                 feedBackStep1, // Дан ли полный ответ на Ваш вопрос?
                 feedBackComplete, // "Спасибо за обращение!", т.е. был дан полный ответ на обращение | конец диалога
                 feedBackRepeat, // "Хотите ли вы уточнить вопрос или записаться на консультирование?", т.е. не был дан полный ответ на обращение
                 wrongRequestAndConsultationBook // первый шаг, если никаких совпадений по ключевым полям нет
        }
        
        let id: String
        let userId: Int
        let step: Int
        let message: String
        let chatBotMessageResponseType: ChatBotMessageResponseType
    }
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func chatBotHandle(with data: ChatBotHandleData, completion: @escaping (Result<ChatBotHandleData, Error>) -> Void) {
        networkManager.request(
            endpoint: OpenControlEndpoint.chatBotHandle(
                id: data.id,
                userId: data.userId,
                step: data.step,
                message: data.message,
                chatBotMessageResponseType: data.chatBotMessageResponseType.rawValue
            ),
            completion: completion
        )
    }
}
