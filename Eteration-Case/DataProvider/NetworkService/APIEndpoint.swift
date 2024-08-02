//
//  APIEndpoint.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
enum APIEndpoint {
    
    static var memorySignatureKey: String?
    
    case getProducts
   
    
    
    var path: String {
        switch self {
        case .getProducts:
            return "https://5fc9346b2af77700165ae514.mockapi.io/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        switch self {
        case .getProducts:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

