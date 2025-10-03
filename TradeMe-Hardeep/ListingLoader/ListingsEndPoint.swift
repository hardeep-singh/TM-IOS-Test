//
//  ListingsEndPoint.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

enum Endpoints {
    static let base = URL(string: "https://api.tmsandbox.co.nz")!
}

extension Endpoints {
    
    enum Listings {
        static func latest(rows: Int = 20,
                           photoSize: String = "FullSize",
                           sortOrder: String = "ExpiryDesc") -> URL {
            var url = base.appendingPathComponent("/v1/listings/latest.json")
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = [
                .init(name: "rows", value: String(rows)),
                .init(name: "photo_size", value: photoSize),
                .init(name: "sort_order", value: sortOrder)
            ]
            url = components.url! // safe
            return url
        }
    }
    
}
