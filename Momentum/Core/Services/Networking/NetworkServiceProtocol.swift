//
//  NetworkServiceProtocol.swift
//  Momentum
//
//  Created by Josh Tienda on 31/07/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod,
        body: Data?
    ) async throws -> T
    
    func upload(data: Data, to endpoint: String) async throws
    func download(from endpoint: String) async throws -> Data
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case networkError(Error)
}
