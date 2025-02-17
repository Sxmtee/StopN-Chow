//
//  ServiceCall.swift
//  StopN'Chow
//
//  Created by mac on 11/02/2025.
//


import Foundation
import SwiftyNetworking

enum NetworkError: Error {
    case invalidURL
    case invalidParameters
    case noData
    case decodingError
    case serverError(String)
}

struct APIResponse<T: Codable>: Codable {
    let status: String
    let message: String
    let payload: T?
    let httpStatusCode: Int
    
    var isSuccess: Bool {
        return status == "1" && (200...299).contains(httpStatusCode)
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case payload = "payload"
        case httpStatusCode = "httpStatusCode"
    }
}

@MainActor
class ServiceCall {
    static func performRequest<T: Codable>(_ request: SwiftyNetworkingRequest) async throws -> APIResponse<T> {
        // Create URLRequest from SwiftyNetworkingRequest
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = request.timeout
        
        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response type")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Server returned status code: \(httpResponse.statusCode)")
        }
        
        // Decode the response
        let decoder = JSONDecoder()
        let baseResponse = try decoder.decode(APIResponse<T>.self, from: data)
        
        // Create new response that includes HTTP status code
        return APIResponse(
            status: baseResponse.status,
            message: baseResponse.message,
            payload: baseResponse.payload,
            httpStatusCode: httpResponse.statusCode
        )
    }
}
