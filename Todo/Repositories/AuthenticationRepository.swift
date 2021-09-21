//
//  AuthenticationRepository.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Moya
import Combine

protocol AuthenticationRepository {
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, MoyaError>
    func logout(token: String) -> AnyPublisher<LogoutResponse, MoyaError>
    func register(request: RegisterRequest) -> AnyPublisher<RegisterResponse, MoyaError>
}

final class AuthenticationRepositoryImpl {
    
    private var provider: MoyaProvider<AuthenticationApi>
    
    init() {
        provider = MoyaProvider<AuthenticationApi>()
    }
}

extension AuthenticationRepositoryImpl: AuthenticationRepository {
    
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, MoyaError> {
        return provider.requestPublisher(.login(request: request)).map(LoginResponse.self)
    }
    
    func logout(token: String) -> AnyPublisher<LogoutResponse, MoyaError> {
        return provider.requestPublisher(.logout(token: token)).map(LogoutResponse.self)
    }
    
    func register(request: RegisterRequest) -> AnyPublisher<RegisterResponse, MoyaError> {
        return provider.requestPublisher(.register(request: request)).map(RegisterResponse.self)
    }
    
}
