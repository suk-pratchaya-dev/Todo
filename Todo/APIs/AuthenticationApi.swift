//
//  AuthenticationApi.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation
import Moya

enum AuthenticationApi {
    case login(request: LoginRequest)
    case logout(token: String)
    case register(request: RegisterRequest)
}

extension AuthenticationApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api-nodejs-todolist.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .logout:
            return "/user/logout"
        case .register:
            return "/user/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .logout, .register:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(request):
            return .requestParameters(parameters: request.toDictionary(), encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain
        case let .register(request):
            return .requestParameters(parameters: request.toDictionary(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .logout(token):
            return [
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)"
            ]
        default:
            return ["Content-Type" : "application/json"]
        }
    }
    
}
