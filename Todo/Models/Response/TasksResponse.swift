//
//  TasksResponse.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

struct TasksResponse: Codable {
    let count: Int
    let tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case count
        case tasks = "data"
    }
}
