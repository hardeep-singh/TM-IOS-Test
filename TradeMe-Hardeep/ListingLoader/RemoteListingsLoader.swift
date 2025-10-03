//
//  ListingUseCase.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

enum ListingReserveState {
    case none
    case met
    case notMet
    case notApplicable
}

struct Listing {
    
    let id: Int
    let title: String?
    let region: String?
    let buyNowPrice: Decimal?
    let reserveState: ListingReserveState
    let priceDisplay: String
    let pictureHref: String?
    let isClassified: Bool
    
}

protocol ListingLoader {
    func execute() async throws -> [Listing]
}

class RemoteListingsLoader: ListingLoader {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClientImp()) {
        self.httpClient = httpClient
    }
    
    func execute() async throws -> [Listing] {
        let endPoint = Endpoints.Listings.latest(rows: 20)
        return ListingMapper.map(response: try await httpClient.get(url: endPoint))
    }
    
}
