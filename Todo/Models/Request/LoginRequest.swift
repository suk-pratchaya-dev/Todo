//
//  LoginRequest.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

struct LoginRequest: Codable {
    let username, password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "email"
        case password
    }
}
