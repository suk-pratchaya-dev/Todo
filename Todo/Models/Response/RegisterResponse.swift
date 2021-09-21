//
//  RegisterResponse.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

struct RegisterResponse: Codable {
    let token: String
    let user: User
}
