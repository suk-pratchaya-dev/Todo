//
//  UserDefaultsUseCase.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

protocol UserDefaultsUseCase {
    func getIsLogin() -> Bool
    func setIslogin(isLogin: Bool)
}

final class UserDefaultsUseCaseImpl {
    
    private var repository: UserDefaultsRepository
    
    init(repository: UserDefaultsRepository = UserDefaultsRepositoryImpl()) {
        self.repository = repository
    }
}

extension UserDefaultsUseCaseImpl: UserDefaultsUseCase {
    
    func getIsLogin() -> Bool {
        guard let isLogin: Bool = repository.get(key: .isLogin) as? Bool else {
            return false
        }
        return isLogin
    }
    
    func setIslogin(isLogin: Bool) {
        repository.set(value: isLogin, key: .isLogin)
    }
    
}
