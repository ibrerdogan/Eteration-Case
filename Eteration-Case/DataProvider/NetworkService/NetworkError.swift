//
//  NetworkError.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int, message: String?)
    case requestCreationError(Error)
    case unknownError
    case userPrivateKeyRetrievalFailure
    case userPrivateKeyCastFailure
}
