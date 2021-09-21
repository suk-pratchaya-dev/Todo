//
//  KeychainUseCase.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

protocol KeychainUseCase {
    func get(key: KeychainKeys, completion: KeychainGetCompletion)
    func set(value: String, key: KeychainKeys, completion: Completion)
    func remove(key: KeychainKeys, completion: Completion)
}

final class KeychainUseCaseImpl {
    
    private var repository: KeychainRepository
    
    init(repository: KeychainRepository = KeychainRepositoryImpl()) {
        self.repository = repository
    }
}

extension KeychainUseCaseImpl: KeychainUseCase {
    
    func get(key: KeychainKeys, completion: (String?, Bool) -> Void) {
        repository.get(key: key, completion: completion)
    }
    
    func set(value: String, key: KeychainKeys, completion: (Bool) -> Void) {
        repository.set(value: value, key: key, completion: completion)
    }
    
    func remove(key: KeychainKeys, completion: (Bool) -> Void) {
        repository.remove(key: key, completion: completion)
    }
    
    
}
