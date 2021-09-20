//
//  TaskRowViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

class TaskRowViewModel: ObservableObject {
    
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
}
