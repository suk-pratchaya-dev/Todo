//
//  MainViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var isLogin: Bool
    
    private var subsctiptionIsLogin: AnyCancellable?
    
    init() {
        self.isLogin = false
        observedIsLogin()
    }
    
    func observedIsLogin() {
        subsctiptionIsLogin = AuthenticationManager.shared.isLogin.sink { isLogin in
            self.isLogin = isLogin
        }
    }
    
    func logout() {
        AuthenticationManager.shared.logout()
    }
    
}
