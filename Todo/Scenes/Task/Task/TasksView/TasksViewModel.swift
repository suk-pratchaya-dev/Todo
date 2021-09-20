//
//  TasksViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

class TasksViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    init() {
        for index in 1...10 {
            tasks.append(Task(id: index, description: "\(index)", lastUpdate: "\(index)", isCompleted: true))
        }
    }
    
}
