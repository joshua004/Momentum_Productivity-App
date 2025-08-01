//
//  APIService.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

class APIService: NetworkServiceProtocol {
    private let session = URLSession.shared
    private let baseURL = "https://api.momentum.com" // Placeholder URL
    
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod,
        body: Data? = nil
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = body
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.networkError(URLError(.badServerResponse))
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    func upload(data: Data, to endpoint: String) async throws {
        // Implementation for file uploads
        // Left empty for future implementation
    }
    
    func download(from endpoint: String) async throws -> Data {
        // Implementation for file downloads
        // Left empty for future implementation
        return Data()
    }
}
