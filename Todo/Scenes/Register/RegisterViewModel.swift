//
//  RegisterViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    private var subscriptionIsRegisterSuccess: AnyCancellable?
    
    init() {
        
    }
    
    func register(username: String,
                  password: String,
                  name: String,
                  age: String,
                  isSuccess: ((Bool) -> Void)?) {
        if username.isEmpty || password.isEmpty || name.isEmpty || age.isEmpty {
            isSuccess?(false)
        } else {
            let age: UInt = UInt(age) ?? 0
            let request: RegisterRequest = RegisterRequest(name: name, email: username, password: password, age: age)
            AuthenticationManager.shared.register(request: request)
            subscriptionIsRegisterSuccess = AuthenticationManager.shared.isRegisterSuccess.sink { [weak self] isRegisterSuccess in
                isSuccess?(isRegisterSuccess)
                self?.subscriptionIsRegisterSuccess?.cancel()
            }
        }
    }
    
}
