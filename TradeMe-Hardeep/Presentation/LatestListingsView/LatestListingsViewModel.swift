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
    case listing
    
    var id: String {
        UUID().uuidString
    }
    
    func info() -> (title: String, message: String) {
        switch self {
        case .cart:
            return ("Cart", "Cart Button Clicked")
        case .search:
            return ("Search", "Search Button Clicked")
        case .listing:
            return ("Listing", "Listing")
        }
    }
    
}

class LatestListingsViewModel: ObservableObject {
    
    @Published var listings: [UIOListing] = []
    @Published var alertItem: AlertItemType?
    let listingsLoader: ListingLoader
    
    init(listingsLoader: ListingLoader = RemoteListingsLoader()) {
        self.listingsLoader = listingsLoader
    }
    
    func fetchListings() async {
        do {
            self.listings = try await listingsLoader.execute().map { UIOListing(dto: $0) }
        } catch {
            
        }
    }
    
}

private extension UIOListing {
    
    init(dto: Listing) {
        
        self.id = dto.id
        self.title = dto.title ?? ""
        self.location = dto.region ?? "Unknown"
        if let pictureHref = dto.pictureHref, let url = URL(string: pictureHref) {
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
class MockListingsViewModel: LatestListingsViewModel {
    
    override func fetchListings() async {
        
        self.listings = [
            .init(id: 1,
                  location: "Auckland",
                  title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                  thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253051356.jpg")!),
                  displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                  buyNowPrice: nil),
            
                .init(id: 2,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 3,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 4,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/full/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 5,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 10,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 12,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 13,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 14,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/full/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 15,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 21,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 22,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 23,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 24,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/full/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 25,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 31,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 32,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 33,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 34,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/full/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 35,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 41,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 42,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 43,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 44,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/full/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 45,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/plus/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000")
        ]
    }
    
}
