//
//  AuthService.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

protocol AuthServiceProtocol {
    func auth(
        _ userData: UserLoginRequest,
        userType: UserType,
        completion: @escaping (Result<AuthenticationUserResponse, Error>) -> Void
    )
    func register(
        _ userData: RegisterUserRequest,
        completion: @escaping (Result<RegisterUserResponse, Error>) -> Void
    )
}

final class AuthService: AuthServiceProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func auth(
        _ userData: UserLoginRequest,
        userType: UserType,
        completion: @escaping (Result<AuthenticationUserResponse, Error>) -> Void
    ) {
        networkManager.request(
            endpoint: OpenControlEndpoint.auth(userLoginRequest: userData, userType: userType)) {
                (result: Result<AuthenticationUserResponse, Error>) in
                completion(result)
            }
    }
    
    func register(
        _ userData: RegisterUserRequest,
        completion: @escaping (Result<RegisterUserResponse, Error>) -> Void
    ) {
        networkManager.request(
            endpoint: OpenControlEndpoint.reg(registerReq: userData)) {
                (result: Result<RegisterUserResponse, Error>) in
                completion(result)
            }
    }
}
