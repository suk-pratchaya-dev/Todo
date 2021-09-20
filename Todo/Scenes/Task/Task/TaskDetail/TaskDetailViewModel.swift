//
//  TaskDetailViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func completeTask(isComplete: Bool) {
        
    }
    
}
