//
//  OpenControlEndpoint.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

enum UserType: Int {
    case user, adminUser
}

enum OpenControlEndpoint: Endpoint {
    
    case auth(userLoginRequest: UserLoginRequest, userType: UserType)
    case reg(registerReq: RegisterUserRequest)
    
    case bookConsultation(bookConsultationRequest: BookSlotRequest)
    case consultationSlot(id: String)
    case consultationTopic(id: String)
    case department
    case subDepartment(id: String)
    
    case chatBotHandle(id: String, userId: Int, step: Int, message: String, chatBotMessageResponseType: Int)
    
    var scheme: String {
        switch self {
        default:
            return "http"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "178.170.194.244:5000"
        }
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/Auth/authenticate"
        case .reg:
            return "/Auth/register"
        case .bookConsultation:
            return "/Consultation/book"
        case .consultationSlot(let id):
            return "/ConsultationSlot/by-sub-department/\(id)"
        case .consultationTopic(let id):
            return "/ConsultationTopic/by-sub-department/\(id)"
        case .department:
            return "/Department"
        case .subDepartment(let id):
            return "/SubDepartment/by-department/\(id)"
        case .chatBotHandle:
            return "/ChatBot/handle"
        }
    }
    
    var method: String {
        switch self {
        case .auth:
            return "POST"
        case .reg:
            return "POST"
        case .bookConsultation:
            return "POST"
        case .consultationSlot:
            return "GET"
        case .consultationTopic:
            return "GET"
        case .department:
            return "GET"
        case .subDepartment:
            return "GET"
        case .chatBotHandle:
            return "POST"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .auth(userLoginRequest: let userLoginRequest, userType: let userType):
            let params: [String: Any] = [
                "email": userLoginRequest.email,
                "password": userLoginRequest.password,
                "userType": userType.rawValue
            ]
            return params
        case .reg(registerReq: let registerReq):
            let params: [String: Any] = [
                "firstName": registerReq.firstName,
                "lastName": registerReq.lastName,
                "email": registerReq.email,
                "mobilePhone": registerReq.mobilePhone,
                "password": registerReq.password,
                "repeatPassword": registerReq.repeatPassword,
                "ditSecurityQuestion": registerReq.ditSecurityQuestion ?? "",
                "ditSecurityAnswer": registerReq.ditSecurityAnswer ?? "",
                "middleName": registerReq.middleName ?? ""
            ]
            return params
        case .bookConsultation(let data):
            let params: [String: Any] = [
                "topic": data.topic,
                "userId": data.userId,
                "consultationSlotId": data.consultationSlotId
            ]
            return params
        case .chatBotHandle(let id, let userId, let step, let message, let chatBotMessageResponseType):
            let params: [String: Any] = [
                "id": id,
                "userId": userId,
                "step": step,
                "message": message,
                "chatBotMessageResponseType": chatBotMessageResponseType
            ]
            return params
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
}
