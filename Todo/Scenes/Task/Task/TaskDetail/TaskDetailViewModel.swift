//
//  TaskDetailViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation
import Combine
import Alamofire

class TaskDetailViewModel: ObservableObject {
    
    @Published var task: Task
    @Published var isTaskDeleted: Bool = false
    
    private var todoUseCase: TodoUseCase
    private var subscriptionDeleteTask: AnyCancellable?
    private var subscriptionUpdateTaskById: AnyCancellable?
    
    init(task: Task, todoUseCase: TodoUseCase = TodoUseCaseImpl()) {
        self.task = task
        self.todoUseCase = todoUseCase
    }
    
    func completeTask(isComplete: Bool) {
        let request: TaskRequest = TaskRequest(isCompleted: isComplete, description: task.description ?? "")
        updateTaskById(request: request)
    }
    
    func updateDescription(description: String) {
        let request: TaskRequest = TaskRequest(isCompleted: task.isCompleted ?? false, description: description)
        updateTaskById(request: request)
    }
    
    func deleteTask() {
        let taskId: String = task.id ?? ""
        let token: String = AuthenticationManager.shared.token.value
        subscriptionDeleteTask = todoUseCase.deleteTask(token: token, taskId: taskId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error)
                case .finished:
                    debugPrint("finished")
                    self?.subscriptionDeleteTask?.cancel()
                }
                
            }, receiveValue: { [weak self] isSuccess in
                guard let self = self else { return }
                self.isTaskDeleted = isSuccess
            })
    }
    
    private func updateTaskById(request: TaskRequest) {
        let token: String = AuthenticationManager.shared.token.value
        subscriptionUpdateTaskById = todoUseCase.updateTaskById(token: token,
                                                                taskId: task.id ?? "",
                                                                request: request)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.subscriptionUpdateTaskById?.cancel()
                case .failure(let error):
                    debugPrint(error)
                }
            }, receiveValue: { [weak self] task in
                guard let self = self else { return }
                self.task = task
            })
    }
    
}
