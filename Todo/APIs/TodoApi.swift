//
//  TodoApi.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation
import Moya

enum TodoApi {
    case getAllTask(token: String)
    case getTaskById(token: String, taskId: String)
    case updateTaskById(token: String, taskId: String, request: TaskRequest)
    case createTask(token: String, request: CreateTaskRequest)
    case deleteTask(token: String, taskId: String)
}

extension TodoApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api-nodejs-todolist.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getAllTask, .createTask:
            return "/task"
        case let .getTaskById(_, taskId):
            return "/task/\(taskId)"
        case let .updateTaskById(_, taskId, _):
            return "/task/\(taskId)"
        case let .deleteTask(_, taskId):
            return "/task/\(taskId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllTask, .getTaskById:
            return .get
        case .updateTaskById:
            return .put
        case .createTask:
            return .post
        case .deleteTask:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllTask, .getTaskById, .deleteTask:
            return .requestPlain
        case let .updateTaskById(_, _, request):
            return .requestParameters(parameters: request.toDictionary(), encoding: JSONEncoding.default)
        case let .createTask(_, request):
            return .requestParameters(parameters: request.toDictionary(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .getAllTask(token):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        case let .getTaskById(token, _):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        case let .updateTaskById(token, _, _):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        case let .createTask(token, _):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        case let .deleteTask(token, _):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        }
    }
    
}
