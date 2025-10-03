//
//  H.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

protocol HTTPClient {
    func get<T: Decodable>(url: URL) async throws -> T
}

struct HTTPError: Error, LocalizedError {
    let status: Int
    let body: String?
    var errorDescription: String? { "HTTP \(status): \(body ?? "")" }
}

class HTTPClientImp: HTTPClient {
    
    let session: URLSession
    var authenticator: OAuth1Authenticator
    
    init(session: URLSession = .shared, authenticator: OAuth1Authenticator = OAuth1Authenticator()) {
        self.session = session
        self.authenticator = authenticator
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        
        var req = URLRequest(url: url)
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue(authenticator.authorizationHeader(), forHTTPHeaderField: "Authorization")
        
        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200..<300).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8)
            throw HTTPError(status: http.statusCode, body: body)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
