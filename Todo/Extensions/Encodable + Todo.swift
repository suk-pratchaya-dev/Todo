//
//  Encodable + Todo.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

extension Encodable {
    
    func toDictionary() -> [String : Any] {
        do {
            let data: Data = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
        } catch {
            return [:]
        }
    }
    
}
