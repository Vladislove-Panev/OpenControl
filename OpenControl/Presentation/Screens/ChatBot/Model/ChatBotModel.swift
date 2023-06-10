//  
//  ChatBotModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import Foundation

protocol ChatBotModelOutput: AnyObject {
    func didSuccessGetGreeting(messages: [ChatBotModel.Message])
    func didFailedGetGreeting(error: Error)
}

protocol ChatBotModelInput {
    var output: ChatBotModelOutput? { get set }
    func fetchMessages()
    func searchInfo(with text: String)
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
    let chatBotService: ChatBotService
    let userDefaultsService: UserDefaultsServiceProtocol
    
    // private let messages: [Message] = []
    private var chatBotResponse: ChatBotService.ChatBotHandleData?
    private let id = UUID()
    
    init(chatBotService: ChatBotService, userDefaultsService: UserDefaultsServiceProtocol) {
        self.chatBotService = chatBotService
        self.userDefaultsService = userDefaultsService
    }
}

extension ChatBotModel: ChatBotModelInput {
    func fetchMessages() {
        chatBotService.chatBotHandle(
            with: .init(
                id: id.uuidString,
                userId: (try? userDefaultsService.get(objectType: RegisterUserResponse.self, forKey: .userRegData)?.id) ?? 0,
                step: 0,
                message: "",
                chatBotMessageResponseType: .greeting
            )) { result in
                switch result {
                case .success(let data):
                    var messages: [ChatBotModel.Message] = []
                    if let messageData = data.message.data(using: .utf8) {
                        do {
                            let message = (try JSONSerialization.jsonObject(with: messageData) as? [String: String])?.reduce(into: "", { partialResult, messageDict in
                                partialResult += "\(messageDict.value)\n"
                            })
                            messages.append(.init(sender: .bot, message: message ?? ""))
                        } catch {
                            print(error.localizedDescription)
                            self.output?.didFailedGetGreeting(error: error)
                        }
                    }
                    self.chatBotResponse = data
                    self.output?.didSuccessGetGreeting(messages: messages)
                case .failure(let error):
                    self.output?.didFailedGetGreeting(error: error)
                }
            }
    }
    
    func searchInfo(with text: String) {
        let data = ChatBotService.ChatBotHandleData(
            id: id.uuidString,
            userId: (try? userDefaultsService.get(objectType: RegisterUserResponse.self, forKey: .userRegData)?.id) ?? 0,
            step: chatBotResponse?.step ?? 0,
            message: text,
            chatBotMessageResponseType: chatBotResponse?.chatBotMessageResponseType ?? .greeting
        )
        chatBotService.chatBotHandle(with: data) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
