//  
//  ChatBotModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import Foundation

protocol ChatBotModelOutput: AnyObject {
    
}

protocol ChatBotModelInput {
    var output: ChatBotModelOutput? { get set }
    func fetchMessages() -> [ChatBotModel.Message]
}

final class ChatBotModel {
    
    struct Message {
        
        enum Sender {
            case bot, user
        }
        
        let sender: Sender
        let message: String
    }
    
    weak var output: ChatBotModelOutput?
    
    private let messages: [Message] = [
        .init(sender: .bot, message: "Здравствуйте, Алексей! Я робот-помощник. Буду рад ответить на ваш вопрос. Вы можете использовать текст или голосовой набор."),
        .init(sender: .user, message: "Что нужно сделать при проведении работ по мощению и асфальтированию территорий?")
    ]
}

extension ChatBotModel: ChatBotModelInput {
    func fetchMessages() -> [Message] {
        messages
    }
}
