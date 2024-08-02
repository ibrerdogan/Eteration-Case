//
//  NetworkService.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation

class NetworkService {
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        let urlRequest: URLRequest
        do {
            urlRequest = try endpoint.asURLRequest()
            //printRequestDetails(urlRequest: urlRequest)
        } catch {
            throw NetworkError.requestCreationError(error)
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }

        switch httpResponse.statusCode {
        case 200...299:
            break
        default:
            let message = String(data: data, encoding: .utf8)
            throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decoding error \(error) \(error.localizedDescription)")
            throw NetworkError.decodingError(error)
        }
    }
    
    func requestWithoutResponse(endpoint: APIEndpoint) async throws {
        let urlRequest: URLRequest
        do {
            urlRequest = try endpoint.asURLRequest()
            //printRequestDetails(urlRequest: urlRequest)
        } catch {
            throw NetworkError.requestCreationError(error)
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }

        switch httpResponse.statusCode {
        case 200...299:
            break
        default:
            let message = String(data: data, encoding: .utf8)
            throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
        }
    }
    
    private func printRequestDetails(urlRequest: URLRequest) {
        if let url = urlRequest.url {
            print("URL: \(url.absoluteString)")
        }

        if let headers = urlRequest.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }

        if let httpBody = urlRequest.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            print("HTTP Body: \(bodyString)")
        }
    }
}

