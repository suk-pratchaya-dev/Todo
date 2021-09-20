//
//  TaskDetailView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject private var viewModel: TaskDetailViewModel
    
    @State private var isPresentedAlert: Bool = false
    @State private var description: String = ""
    @State private var lastUpdate: String = ""
    @State private var isCompleted: Bool
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
        self.description = viewModel.task.description
        self.lastUpdate = viewModel.task.lastUpdate
        self.isCompleted = viewModel.task.isCompleted
    }
    
    var body: some View {
        Form(content: {
            TextField("Description", text: $description) { isEditing in
                debugPrint("isEditing \(isEditing)")
            } onCommit: {
                debugPrint("onCommit")
                if description.isEmpty {
                    isPresentedAlert = true
                    return
                }
                
                if viewModel.task.description != description {
                    debugPrint("send api update task")
                }
            }

            HStack(content: {
                Text("Last update")
                Spacer()
                Text(lastUpdate)
                    .foregroundColor(.gray)
            })
            
            HStack(content: {
                Text("Status")
                
                Spacer()
                
                Button(action: {
                    isCompleted.toggle()
                }, label: {
                    Image(systemName: isCompleted ? "circle.fill" : "circle")
                        .font(.body)
                })
            })
        })
        .alert(isPresented: $isPresentedAlert, content: {
            Alert(title: Text("Error"), message: Text("Description is empty"), dismissButton: .default(Text("Done")))
        })
        .navigationTitle("Task Deatil")
    }
}
