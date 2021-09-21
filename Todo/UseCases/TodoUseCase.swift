//
//  TodoUseCase.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Combine
import Moya

protocol TodoUseCase {
    func getAllTask(token: String) -> AnyPublisher<[Task], MoyaError>
    func getTaskById(token: String, taskId: String) -> AnyPublisher<Task, MoyaError>
    func updateTaskById(token: String, taskId: String, request: TaskRequest) -> AnyPublisher<Task, MoyaError>
    func createTask(token: String, request: CreateTaskRequest) -> AnyPublisher<Task, MoyaError>
    func deleteTask(token: String, taskId: String) -> AnyPublisher<Bool, MoyaError>
}

final class TodoUseCaseImpl {
    
    private var repository: TodoRepository
    
    init(repository: TodoRepository = TodoRepositoryImpl()) {
        self.repository = repository
    }
}

extension TodoUseCaseImpl: TodoUseCase {
    
    func getAllTask(token: String) -> AnyPublisher<[Task], MoyaError> {
        return repository.getAllTask(token: token)
            .map { $0.tasks }
            .eraseToAnyPublisher()
    }
    
    func getTaskById(token: String, taskId: String) -> AnyPublisher<Task, MoyaError> {
        return repository.getTaskById(token: token, taskId: taskId)
            .filter{ $0.isSuccess }
            .map{ $0.task }
            .eraseToAnyPublisher()
        
    }
    
    func updateTaskById(token: String, taskId: String, request: TaskRequest) -> AnyPublisher<Task, MoyaError> {
        return repository.updateTaskById(token: token, taskId: taskId, request: request)
            .filter{ $0.isSuccess }
            .map{ $0.task }
            .eraseToAnyPublisher()
    }
    
    func createTask(token: String, request: CreateTaskRequest) -> AnyPublisher<Task, MoyaError> {
        return repository.createTask(token: token, request: request)
            .filter{ $0.isSuccess }
            .map{ $0.task }
            .eraseToAnyPublisher()
    }
    
    func deleteTask(token: String, taskId: String) -> AnyPublisher<Bool, MoyaError> {
        return repository.deleteTask(token: token, taskId: taskId)
            .map{ $0.isSuccess }
            .eraseToAnyPublisher()
    }
    
}
