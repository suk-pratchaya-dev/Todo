//
//  TaskResponse.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

struct TaskResponse: Codable {
    let isSuccess: Bool
    let task: Task
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case task = "data"
    }
}
