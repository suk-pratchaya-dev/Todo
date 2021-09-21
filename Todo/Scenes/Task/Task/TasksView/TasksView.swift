//
//  TasksView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject private var viewModel: TasksViewModel

    @State private var description: String = ""
    @State private var isCanAddTask: Bool = false
    
    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.loadAllTasks)
        case .loading:
            Text("Loading...")
        case .failed:
            EmptyView()
        case .loaded(let tasks):
            ZStack(content: {
                VStack {
                    HStack {
                        TextField("Description", text: $description, onEditingChanged: { _ in
                        }, onCommit: {
                            isCanAddTask = !description.isEmpty
                        })
                        
                        Button {
                            viewModel.createTask(description: description)
                            description = ""
                            isCanAddTask = false
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32, alignment: .center)
                        }
                        .disabled(!isCanAddTask)
                        .padding()
                    }
                    .padding()
                    
                    
                    List(tasks) { task in
                        NavigationLink(destination: TaskDetailView(viewModel: TaskDetailViewModel(task: task)),
                                       label: { TaskRowView(viewModel: TaskRowViewModel(task: task)) })
                    }
                }
                
                Button {
                    viewModel.loadAllTasks()
                } label: {
                    Text("Refresh Data")
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
            })
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: TasksViewModel())
    }
}
