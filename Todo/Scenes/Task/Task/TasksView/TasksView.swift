//
//  TasksView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct TasksView: View {
    
    @ObservedObject private var viewModel: TasksViewModel
    
    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.tasks) { task in
            NavigationLink(destination: TaskDetailView(viewModel: TaskDetailViewModel(task: task)),
                           label: { TaskRowView(viewModel: TaskRowViewModel(task: task)) })
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: TasksViewModel())
    }
}
