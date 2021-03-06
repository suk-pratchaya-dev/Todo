//
//  Task.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: String?
    let description, lastUpdate: String?
    let isCompleted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isCompleted = "completed"
        case id = "_id"
        case description
        case lastUpdate = "updatedAt"
    }
}
