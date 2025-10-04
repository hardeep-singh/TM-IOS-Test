//
//  ListingUseCase.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

class RemoteListingsLoader: ListingsLoader {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func execute() async throws -> [Listing] {
        let endPoint = Endpoints.Listings.latest(rows: 20)
        return ListingMapper.map(response: try await httpClient.get(url: endPoint))
    }
    
}
