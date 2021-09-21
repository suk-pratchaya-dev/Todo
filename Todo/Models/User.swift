//
//  User.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

struct User: Codable {
    let age: Int
    let id, name, email, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case age
        case id = "_id"
        case name, email, createdAt, updatedAt
        case v = "__v"
    }
}
