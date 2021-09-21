//
//  TaskRequest.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

struct TaskRequest: Codable {
    let isCompleted: Bool
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case isCompleted = "completed"
        case description
    }
}
