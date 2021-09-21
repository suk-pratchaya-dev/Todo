//
//  AuthenticationManager.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Combine

class AuthenticationManager {
    
    private var _token: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    public var token: CurrentValueSubject<String, Never> {
        get { return self._token }
        set { self._token = newValue }
    }
    
    private var _isLogin: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    public var isLogin: CurrentValueSubject<Bool, Never> {
        get { return self._isLogin }
        set { self._isLogin = newValue }
    }
    
    private var _user: CurrentValueSubject<User?, Never> = CurrentValueSubject<User?, Never>(nil)
    public var user: CurrentValueSubject<User?, Never> {
        get { return self._user }
        set { self._user = newValue }
    }
    
    private var _isLoginSuccess: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    public var isLoginSuccess: CurrentValueSubject<Bool, Never> {
        get { return self._isLoginSuccess }
        set { self._isLoginSuccess = newValue }
    }
    
    private var _isLogoutSuccess: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    public var isLogoutSuccess: CurrentValueSubject<Bool, Never> {
        get { return self._isLogoutSuccess }
        set { self._isLogoutSuccess = newValue }
    }
    
    private var _isRegisterSuccess: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    public var isRegisterSuccess: CurrentValueSubject<Bool, Never> {
        get { return self._isRegisterSuccess }
        set { self._isRegisterSuccess = newValue }
    }
    
    static let shared: AuthenticationManager = AuthenticationManager()
    
    private var authenTicationUseCase: AuthenticationUseCase = AuthenticationUseCaseImpl()
    private var userDefaultsUseCase: UserDefaultsUseCase = UserDefaultsUseCaseImpl()
    private var keychainUseCase: KeychainUseCase = KeychainUseCaseImpl()
    
    private var subsriptionLogin: AnyCancellable?
    private var subsriptionLogout: AnyCancellable?
    private var subsriptionRegister: AnyCancellable?
    
    private init() {
        self.isLogin.send(userDefaultsUseCase.getIsLogin())
        
        keychainUseCase.get(key: .token) { [weak self] token, isSuccess in
            guard let self = self else { return }
            self.token.send(token ?? "")
        }
    }
    
    func login(request: LoginRequest) {
        subsriptionLogin = authenTicationUseCase.login(request: request).sink { _ in
            Self.shared.isLoginSuccess.send(false)
        } receiveValue: { [weak self] loginResponse in
            guard let self = self else { return }
            self.token.send(loginResponse.token)
            self.user.send(loginResponse.user)
            
            self.userDefaultsUseCase.setIslogin(isLogin: true)
            self.keychainUseCase.set(value: loginResponse.token, key: .token) { _ in }
            
            self.isLogin.send(true)
            self.isLoginSuccess.send(true)
        }
    }
    
    func logout() {
        subsriptionLogout = authenTicationUseCase.logout(token: self.token.value).sink { _ in
            Self.shared.isLogoutSuccess.send(false)
        } receiveValue: { [weak self] logoutResponse in
            guard let self = self else { return }
            if logoutResponse.isSuccess {
                self.isLogin.send(false)
                self.isLogoutSuccess.send(true)
                self.userDefaultsUseCase.setIslogin(isLogin: false)
            } else {
                self.isLogoutSuccess.send(false)
            }
        }
    }
    
    func register(request: RegisterRequest) {
        subsriptionRegister = authenTicationUseCase.register(request: request).sink(receiveCompletion: { _ in
            self.isRegisterSuccess.send(false)
        }, receiveValue: { registerResponse in
            self.token.send(registerResponse.token)
            self.user.send(registerResponse.user)
            
            self.userDefaultsUseCase.setIslogin(isLogin: true)
            self.keychainUseCase.set(value: registerResponse.token, key: .token) { _ in }
            
            self.isLogin.send(true)
            self.isRegisterSuccess.send(true)
        })
    }
}
