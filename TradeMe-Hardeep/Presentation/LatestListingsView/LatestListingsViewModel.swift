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

@MainActor
class LatestListingsViewModel: ObservableObject {
    
    @Published var listings: [UIOListing] = []
    @Published var alertItem: AlertItemType?
    nonisolated let listingsLoader: ListingsLoader
    private var task: Task<Void, Never>?
    init(listingsLoader: ListingsLoader) {
        self.listingsLoader = listingsLoader
    }
    
    func fetchListings() async {
        if let existingTask = task {
            await existingTask.value
            return
        }
        
        task = Task { @MainActor in
            defer { self.task = nil }
            do {
                let fetchedListings = try await listingsLoader.execute().map { UIOListing(dto: $0) }
                guard !Task.isCancelled else { return }
                self.listings = fetchedListings
                self.alertItem = nil
            } catch {
                guard !Task.isCancelled else { return }
                self.listings = []
                self.alertItem = .error(error.localizedDescription)
            }
        }
        await task?.value
    }
    
    deinit {
        task?.cancel()
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
                .presentation(.narrow)
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
