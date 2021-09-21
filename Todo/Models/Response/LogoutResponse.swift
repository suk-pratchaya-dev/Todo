//
//  LogoutResponse.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

struct LogoutResponse: Codable {
    let isSuccess: Bool
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
    }
}
