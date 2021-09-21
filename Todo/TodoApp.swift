//
//  TodoApp.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

@main
struct TodoApp: App {
    
    init() {
        // init app
        debugPrint("app launch with option")
        _ = AuthenticationManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
