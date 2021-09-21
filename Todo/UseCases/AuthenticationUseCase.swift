//
//  AuthenticationUseCase.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Combine
import Moya

protocol AuthenticationUseCase {
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, MoyaError>
    func logout(token: String) -> AnyPublisher<LogoutResponse, MoyaError>
    func register(request: RegisterRequest) -> AnyPublisher<RegisterResponse, MoyaError>
}

final class AuthenticationUseCaseImpl {
    
    private var authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()) {
        self.authenticationRepository = authenticationRepository
    }
}

extension AuthenticationUseCaseImpl: AuthenticationUseCase {
    
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, MoyaError> {
        return authenticationRepository.login(request: request).eraseToAnyPublisher()
    }
    
    func logout(token: String) -> AnyPublisher<LogoutResponse, MoyaError> {
        return authenticationRepository.logout(token: token).eraseToAnyPublisher()
    }
    
    func register(request: RegisterRequest) -> AnyPublisher<RegisterResponse, MoyaError> {
        return authenticationRepository.register(request: request).eraseToAnyPublisher()
    }
    
}
