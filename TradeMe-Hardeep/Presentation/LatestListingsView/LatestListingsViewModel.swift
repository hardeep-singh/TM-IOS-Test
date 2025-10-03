//
//  LatestListingsViewModel.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation
import Combine

enum AlertItemType: Identifiable {
    case cart
    case search
    case listing(UIOListing)
    case buyNow(UIOListing)
    case error(String)
    
    var id: String {
        UUID().uuidString
    }
    
    func buttonTitle() -> String {
        switch self {
        case .buyNow:
            return Constants.buyNow
        default:
            return Constants.ok
        }
    }
    
    func info() -> (title: String, message: String) {
        switch self {
        case .cart:
            return ("Cart", "Cart Button Clicked")
        case .search:
            return ("Search", "Search Button Clicked")
        case let .listing(listing):
            return ("Listing", "\(listing.title)")
        case let .buyNow(listing):
            return ("\(listing.buyNowPrice!)", "\(listing.title)")
        case let .error(message):
            return ("‼️ Error", message)
        }
    }
    
}

class LatestListingsViewModel: ObservableObject {
    
    @Published var listings: [UIOListing] = []
    @Published var alertItem: AlertItemType?
    let listingsLoader: ListingLoader
    
    init(listingsLoader: ListingLoader) {
        self.listingsLoader = listingsLoader
    }
    
    func fetchListings() async {
        do {
            self.listings = try await listingsLoader.execute().map { UIOListing(dto: $0) }
        } catch {
            self.listings = []
            self.alertItem = .error(error.localizedDescription)
        }
    }
    
}

private extension UIOListing {
    
    init(dto: Listing) {
        
        self.id = dto.id
        self.title = dto.title ?? ""
        self.location = dto.region ?? "Unknown"
        let imageUrl: String? = dto.images.first ?? dto.pictureHref
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            self.thumbnil = .remote(url)
        } else {
            self.thumbnil = .local("")
        }
        
        var buyNowPrice: String? = nil
        if let price = dto.buyNowPrice {
            buyNowPrice = price.formatted(
                .currency(code: "NZD")
                .precision(.fractionLength(2)))
        }
            
        if dto.isClassified {
            self.displayPrice = .init(header: dto.priceDisplay, subheader: nil)
            self.buyNowPrice = buyNowPrice
        } else {
            var subheader: String? = nil
           switch dto.reserveState {
            case .met:
                subheader = "Reserve Met"
            case .notMet:
                subheader = "Reserve Not Met"
            case .none:
                subheader = "No Reserve"
            case .notApplicable:
                subheader = nil
            }
            self.displayPrice = .init(header: dto.priceDisplay, subheader: subheader)
            self.buyNowPrice = buyNowPrice
        }
       
    }
    
}
