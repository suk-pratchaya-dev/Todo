//
//  UserDefaultsRepository.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

enum UserDefaultsKeys: String {
    case isLogin = "isLogin"
}

protocol UserDefaultsRepository {
    func get(key: UserDefaultsKeys) -> Any?
    func set(value: Any?, key: UserDefaultsKeys)
}

final class UserDefaultsRepositoryImpl {
    
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsRepositoryImpl: UserDefaultsRepository {
    
    func get(key: UserDefaultsKeys) -> Any? {
        return userDefaults.value(forKey: key.rawValue)
    }
    
    func set(value: Any?, key: UserDefaultsKeys) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }
    
}
