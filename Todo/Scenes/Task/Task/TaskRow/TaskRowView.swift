//
//  TaskRowView.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import SwiftUI

struct TaskRowView: View {
    
    @ObservedObject private var viewModel: TaskRowViewModel
    
    init(viewModel: TaskRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(content: {
            Image(systemName: "doc.circle.fill")
                .font(.title)
            
            VStack(alignment: .leading, spacing: nil, content: {
                Text(viewModel.task.description ?? "")
                    .font(.headline)
                Text(viewModel.task.lastUpdate ?? "")
                    .font(.subheadline)
            })
            
            Spacer()
            
            Image(systemName: viewModel.task.isCompleted ?? false ? "circle.fill" : "circle")
                .font(.body)
        })
        
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        let task: Task = Task(id: "1", description: "description", lastUpdate: "12/02/2021", isCompleted: false)
        TaskRowView(viewModel: TaskRowViewModel(task: task))
    }
}
