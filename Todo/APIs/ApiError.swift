//
//  ApiError.swift
//  Todo
//
//  Created by Pratchaya Suksena on 21/9/2564 BE.
//

import Foundation

typealias OnError = ((Error) -> Void)?

enum ApiError: Error {
    case decodingFail
    case somethingFail
}
