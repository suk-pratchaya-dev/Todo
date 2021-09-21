//
//  RegisterRequest.swift
//  Todo
//
//  Created by Pratchaya Suksena on 20/9/2564 BE.
//

import Foundation

struct RegisterRequest: Codable {
    let name, email, password: String
    let age: UInt
    
    enum CodingKeys: String, CodingKey {
        case name, email, password, age
    }
}
