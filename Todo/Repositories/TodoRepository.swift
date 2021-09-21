//
//  TodoRepository.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation
import Moya
import Combine

protocol TodoRepository {
    func getAllTask(token: String) -> AnyPublisher<TasksResponse, MoyaError>
    func getTaskById(token: String, taskId: String) -> AnyPublisher<TaskResponse, MoyaError>
    func updateTaskById(token: String, taskId: String, request: TaskRequest) -> AnyPublisher<TaskResponse, MoyaError>
    func createTask(token: String, request: CreateTaskRequest) -> AnyPublisher<TaskResponse, MoyaError>
    func deleteTask(token: String, taskId: String) -> AnyPublisher<TaskResponse, MoyaError>
}

final class TodoRepositoryImpl {
    
    private var provider: MoyaProvider<TodoApi>
    
    init() {
        provider = MoyaProvider<TodoApi>()
    }
}

extension TodoRepositoryImpl: TodoRepository {
    
    func getAllTask(token: String) -> AnyPublisher<TasksResponse, MoyaError> {
        return provider.requestPublisher(.getAllTask(token: token)).map(TasksResponse.self)
    }
    
    func getTaskById(token: String, taskId: String) -> AnyPublisher<TaskResponse, MoyaError> {
        return provider.requestPublisher(.getTaskById(token: token, taskId: taskId)).map(TaskResponse.self)
    }
    
    func updateTaskById(token: String, taskId: String, request: TaskRequest) -> AnyPublisher<TaskResponse, MoyaError> {
        return provider.requestPublisher(.updateTaskById(token: token, taskId: taskId, request: request)).map(TaskResponse.self)
    }
    
    func createTask(token: String, request: CreateTaskRequest) -> AnyPublisher<TaskResponse, MoyaError> {
        return provider.requestPublisher(.createTask(token: token, request: request)).map(TaskResponse.self)
    }
    
    func deleteTask(token: String, taskId: String) -> AnyPublisher<TaskResponse, MoyaError> {
        return provider.requestPublisher(.deleteTask(token: token, taskId: taskId)).map(TaskResponse.self)
    }
    
}
