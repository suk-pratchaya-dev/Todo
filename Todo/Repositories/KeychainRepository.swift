//
//  KeychainRepository.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import KeychainAccess

typealias Completion = (_ isSuccess: Bool) -> Void
typealias KeychainGetCompletion = (_ value: String?, _ isSuccess: Bool) -> Void

enum KeychainKeys: String {
    case username = "username"
    case password = "password"
    case token = "token"
}

protocol KeychainRepository {
    func get(key: KeychainKeys, completion: KeychainGetCompletion)
    func set(value: String, key: KeychainKeys, completion: Completion)
    func remove(key: KeychainKeys, completion: Completion)
}

final class KeychainRepositoryImpl {
    
    private var keychain: Keychain
    
    init(services: String = Bundle.main.bundleIdentifier ?? "com.pratchaya.Todo") {
        self.keychain = Keychain(service: services)
    }
    
}

extension KeychainRepositoryImpl: KeychainRepository {
    
    func get(key: KeychainKeys, completion: KeychainGetCompletion) {
        do {
            guard let result: String = try keychain.get(key.rawValue) else {
                completion(nil, false)
                return
            }
            completion(result, true)
        } catch {
            completion(nil, false)
        }
    }
    
    func set(value: String, key: KeychainKeys, completion: Completion) {
        do {
            _ = try keychain.set(value, key: key.rawValue)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func remove(key: KeychainKeys, completion: Completion) {
        do {
            try keychain.remove(key.rawValue)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
}
