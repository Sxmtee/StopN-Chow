//
//  ServiceCall.swift
//  StopN'Chow
//
//  Created by mac on 11/02/2025.
//


import Foundation

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
    
    var isSuccess: Bool {
        return status == "1"
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case payload = "payload"
    }
}

@MainActor
class ServiceCall {
    static func postWithResponse<T: Codable>(
        parameters: [String: Any],
        path: String,
        isToken: Bool = false
    ) async throws -> APIResponse<T> {
        guard let url = URL(string: path) else {
            throw NetworkError.invalidURL
        }
        
        // Convert parameters to URL-encoded string
        let parameterString = parameters.map { key, value in
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(value)"
            return "\(encodedKey)=\(encodedValue)"
        }.joined(separator: "&")
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
//        if isToken {
//            request.setValue(MainViewModel.shared.userObj.authToken, forHTTPHeaderField: "access_token")
//        }
        
        request.httpBody = parameterString.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response type")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Server returned status code: \(httpResponse.statusCode)")
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NetworkError.decodingError
        }
        
        #if DEBUG
        print("Response:", jsonObject)
        #endif
        
        // Extract status and message
        let status = jsonObject[KKey.status] as? String ?? ""
        let message = jsonObject[KKey.message] as? String ?? ""
        
        // Handle payload
        var payload: T? = nil
        if let payloadData = jsonObject[KKey.payload],
           let payloadJSON = try? JSONSerialization.data(withJSONObject: payloadData) {
            payload = try? JSONDecoder().decode(T.self, from: payloadJSON)
        }
        
        return APIResponse(status: status, message: message, payload: payload)
    }
}
