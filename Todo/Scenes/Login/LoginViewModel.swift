//
//  LoginViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    private var subscriptionIsLoginSuccess: AnyCancellable?
    
    init() {
    }
    
    func login(username: String, password: String, isSuccess: ((Bool) -> Void)?) {
        AuthenticationManager.shared.login(request: LoginRequest(username: username, password: password))
        subscriptionIsLoginSuccess = AuthenticationManager.shared.isLoginSuccess.sink { [weak self] isLoginSuccess in
            isSuccess?(isLoginSuccess)
            self?.subscriptionIsLoginSuccess?.cancel()
        }
    }
    
}
