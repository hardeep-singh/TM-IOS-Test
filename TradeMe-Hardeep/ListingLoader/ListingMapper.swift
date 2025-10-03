//
//  Listing.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

struct ListingMapper {
    
    struct RemoteListingResponse: Codable {
        let TotalCount: Int
        let Page: Int
        let PageSize: Int
        let List: [RemoteListing]
    }

    enum RemoteReserveState: Int, Codable {
        case None = 0
        case Met = 1
        case NotMet = 2
        case NotApplicable = 3
    }

    struct RemoteListing: Codable {
        
        let ListingId: Int
        let Title: String?
        let Region: String?
        let ReserveState: RemoteReserveState?
        let BuyNowPrice: Decimal?
        let PriceDisplay: String
        let PictureHref: String?
        let IsClassified: Bool?
        let PhotoUrls: [String]?
        
    }

    static func map(response: RemoteListingResponse) -> [Listing] {
        return response
            .List
            .map { Listing(response: $0) }
    }
    
}


private extension Listing {
    
    init(response: ListingMapper.RemoteListing) {
        self.id = response.ListingId
        self.title = response.Title
        self.region = response.Region
        self.buyNowPrice = response.BuyNowPrice
        if let state = response.ReserveState {
            self.reserveState = .init(state: state)
        } else {
            self.reserveState = .init(state: .NotApplicable)
        }
       
        self.priceDisplay = response.PriceDisplay
        self.pictureHref = response.PictureHref
        self.images = response.PhotoUrls ?? []
        self.isClassified = response.IsClassified ?? false
    }
    
}

extension ListingReserveState {
    
    init(state: ListingMapper.RemoteReserveState) {
        switch state {
        case .None:
            self = .none
        case .Met:
            self = .met
        case .NotMet:
            self = .notMet
        case .NotApplicable:
            self = .notApplicable
        }
    }
    
}
