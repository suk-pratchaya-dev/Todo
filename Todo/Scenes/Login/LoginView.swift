//
//  LoginView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    @Binding var isPresented: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    init(viewModel: LoginViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationView(content: {
            VStack(alignment: .center, spacing: 20, content: {
                VStack(content: {
                    TextField("Username", text: $username)
                    
                    Divider()
                    
                    SecureField("Password", text: $password)
                })
                .frame(width: 250, alignment: .center)
                
                .padding()
                .background(Color.init(UIColor.systemGray6))
                .cornerRadius(10.0)
                
                Button(action: {
                    viewModel.login(username: username, password: password)
                }, label: {
                    Text("Login")
                })
                
                Spacer()
            })
            .navigationTitle("Login")
        })
    }
}
