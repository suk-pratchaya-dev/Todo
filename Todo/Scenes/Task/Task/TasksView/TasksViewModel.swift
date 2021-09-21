//
//  TasksViewModel.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation
import Combine
import Alamofire

class TasksViewModel: ObservableObject {
    
    public enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Task])
    }
    
    private var todoUseCase: TodoUseCase
    private var subscriptionGetAllTask: AnyCancellable?
    private var subscriptionCreateTask: AnyCancellable?
    
    @Published var state: State = .idle
    
    init(todoUseCase: TodoUseCase = TodoUseCaseImpl()) {
        self.todoUseCase = todoUseCase
    }
    
    func loadAllTasks() {
        state = .loading
        let token: String = AuthenticationManager.shared.token.value
        subscriptionGetAllTask = todoUseCase.getAllTask(token: token).sink { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case let .failure(moyaError):
                debugPrint(moyaError)
                self.state = .failed(moyaError)
            case .finished:
                debugPrint("finished")
                self.subscriptionGetAllTask?.cancel()
            }
        } receiveValue: { [weak self] tasks in
            guard let self = self else { return }
            self.state = .loaded(tasks)
        }
    }
    
    func createTask(description: String) {
        let token: String = AuthenticationManager.shared.token.value
        subscriptionCreateTask = todoUseCase.createTask(token: token, request: CreateTaskRequest(description: description))
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error)
                case .finished:
                    self?.subscriptionCreateTask?.cancel()
                }
            } receiveValue: { [weak self] task in
                guard let self = self else { return }
                self.loadAllTasks()
            }
        
    }
    
}
