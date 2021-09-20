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
    
    @State var isLoggedIn: Bool = true
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView(content: {
            ZStack(content: {
                if isLoggedIn {
                    TasksView(viewModel: TasksViewModel())
                } else {
                    Text("Please Login to see all task")
                }
            })
            .navigationTitle("Tasks")
            .navigationBarItems(leading: Button(action: { isPresentedRegisterView = true },
                                                label: { Text("Register") }),
                                trailing: Button(action: { isPresentedLoginView = true },
                                                 label: { Text("Login") }))
            .sheet(isPresented: $isPresentedLoginView, content: {
                LoginView(viewModel: LoginViewModel(), isPresented: $isPresentedLoginView)
            })
            .sheet(isPresented: $isPresentedRegisterView, content: {
                RegisterView(isPresented: $isPresentedRegisterView)
            })
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
