//
//  UserDefaultsService.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func set(key: UserDefaultsKeys, value: Any?)
    func get<T>(key: UserDefaultsKeys) -> T?
    func remove(key: UserDefaultsKeys)
    func synchronize()
    func set<T: Codable>(object: T, forKey: UserDefaultsKeys) throws
    func get<T: Codable>(objectType: T.Type, forKey: UserDefaultsKeys) throws -> T?
}

enum UserDefaultsKeys {
    case userAuthData
    case userRegData
    
    var key: String {
        switch self {
        case .userAuthData:
            return "userAuthData"
        case .userRegData:
            return "userRegData"
        }
    }
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    func set(key: UserDefaultsKeys, value: Any?) {
        userDefaults.set(value, forKey: key.key)
    }
    
    func get<T>(key: UserDefaultsKeys) -> T? {
        return userDefaults.value(forKey: key.key) as? T
    }
    
    func remove(key: UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.key)
    }
    
    func synchronize() {
        userDefaults.synchronize()
    }
    
    public func set<T: Codable>(object: T, forKey: UserDefaultsKeys) throws {
        let jsonData = try JSONEncoder().encode(object)
        userDefaults.set(jsonData, forKey: forKey.key)
    }
    
    public func get<T: Codable>(objectType: T.Type, forKey: UserDefaultsKeys) throws -> T? {
        guard let result = userDefaults.value(forKey: forKey.key) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
}
