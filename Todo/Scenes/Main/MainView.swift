//
//  MainView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    @State var isPresentedLoginView: Bool = false
    @State var isPresentedRegisterView: Bool = false
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView(content: {
            ZStack(content: {
                if viewModel.isLogin {
                    TasksView(viewModel: TasksViewModel())
                        .navigationBarItems(trailing: Button(action: { viewModel.logout() },
                                                             label: { Text("Logout") }))
                } else {
                    Text("Please Login to see all task")
                        .navigationBarItems(leading: Button(action: { isPresentedRegisterView = true },
                                                            label: { Text("Register") }),
                                            trailing: Button(action: { isPresentedLoginView = true },
                                                             label: { Text("Login") }))
                }
            })
            .navigationTitle("Tasks")
            .sheet(isPresented: $isPresentedLoginView, content: {
                LoginView(viewModel: LoginViewModel(), isPresented: $isPresentedLoginView)
            })
            .sheet(isPresented: $isPresentedRegisterView, content: {
                RegisterView(viewModel: RegisterViewModel(), isPresented: $isPresentedRegisterView)
            })
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
