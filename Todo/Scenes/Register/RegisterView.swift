//
//  RegisterView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var viewModel: RegisterViewModel
    
    @Binding var isPresented: Bool
    
    @State private var isPresentedAlert: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var age: String = ""
    
    init(viewModel: RegisterViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationView(content: {
            VStack(alignment: .center, spacing: 20, content: {
                VStack(content: {
                    TextField("Name", text: $name)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                    
                    Divider()
                    
                    TextField("Email", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    
                    Divider()
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                    
                    Divider()
                    
                    TextField("Age", text: $age)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                    
                    Divider()
                    
                })
                    .frame(width: 250, alignment: .center)
                    .padding()
                    .background(Color.init(UIColor.systemGray6))
                    .cornerRadius(10.0)
                
                Button(action: {
                    viewModel.register(username: username,
                                       password: password,
                                       name: name,
                                       age: age) { isSuccess in
                        if isSuccess {
                            isPresented = false
                        } else {
                            isPresentedAlert = true
                        }
                    }
                }, label: {
                    Text("Register")
                })
                
                Spacer()
            })
                .navigationTitle("Register")
                .alert(isPresented: $isPresentedAlert, content: {
                    Alert(title: Text("Register"), message: Text("Register Fail"), dismissButton: .default(Text("OK")))
                })
        })
    }
}
