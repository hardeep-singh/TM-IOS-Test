//
//  ListingsLoader.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 04/10/25.
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
    let images: [String]
    
}

protocol ListingsLoader {
    func execute() async throws -> [Listing]
}
