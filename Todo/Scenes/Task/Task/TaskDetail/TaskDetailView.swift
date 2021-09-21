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
    @State private var isPresentedDeleteAlert: Bool = false
    @State private var description: String
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
        self.description = viewModel.task.description ?? ""
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
                    viewModel.updateDescription(description: description)
                }
            }

            HStack(content: {
                Text("Last update")
                Spacer()
                Text(viewModel.task.lastUpdate ?? "")
                    .foregroundColor(.gray)
            })
            
            HStack(content: {
                Text("Status")
                
                Spacer()
                
                Button(action: {
                    viewModel.completeTask(isComplete: !(viewModel.task.isCompleted ?? false))
                }, label: {
                    Image(systemName: viewModel.task.isCompleted ?? false ? "circle.fill" : "circle")
                        .font(.body)
                })
            })
        })
        .onChange(of: viewModel.isTaskDeleted, perform: { isTaskDeleted in
            if isTaskDeleted {
                isPresentedDeleteAlert = true
            }
        })
        .alert(isPresented: $isPresentedAlert, content: {
            Alert(title: Text("Error"), message: Text("Description is empty"), dismissButton: .default(Text("Done")))
        })
        .alert(isPresented: $isPresentedDeleteAlert, content: {
            Alert(title: Text("Delete Task"), message: Text("Task is deleted"), dismissButton: .default(Text("OK")))
        })
        .navigationTitle("Task Deatil")
        .navigationBarItems(trailing: Button(action: {
            viewModel.deleteTask()
        }, label: {
            Image(systemName: "trash.circle.fill")
                .resizable()
                .scaledToFit()
                .font(.title)
        }))
    }
}
