//
//  MockListingLoader.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 03/10/25.
//

import Foundation

class MockLoader: ListingLoader {
    func execute() async throws -> [Listing] {
        return []
    }
}

class MockListingsViewModel: LatestListingsViewModel {
    
    init() {
        super.init(listingsLoader: MockLoader())
    }
    
    override func fetchListings() async {
        
        self.listings = [
            .init(id: 1,
                  location: "Auckland",
                  title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                  thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253051356.jpg")!),
                  displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                  buyNowPrice: nil),
            
                .init(id: 2,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 3,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 4,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 5,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 10,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 12,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 13,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 14,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 15,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 21,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 22,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 23,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 24,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 25,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 31,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 32,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 33,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 34,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 35,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000"),
            
                .init(id: 41,
                      location: "Auckland",
                      title: "2014 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253051356.jpg")!),
                      displayPrice: .init(header: "Asking Price $10,000", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 42,
                      location: "Auckland",
                      title: "2016 Mazda Axela HYBRID !! TOP SPEC !! FULLY LOADED !!",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2249589974.jpg")!),
                      displayPrice: .init(header: "$6000", subheader: "No reserve"),
                      buyNowPrice: "$9000"),
            
                .init(id: 43,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253041046.jpg")!),
                      displayPrice: nil,
                      buyNowPrice: "$8000"),
            
                .init(id: 44,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253040488.jpg")!),
                      displayPrice: .init(header: "Price by negotiation", subheader: nil),
                      buyNowPrice: nil),
            
                .init(id: 45,
                      location: "Auckland!",
                      title: "2015 Ford Kuga Titanium Awd Diesel",
                      thumbnil: .remote(URL(string: "https://trademe.tmcdn.co.nz/photoserver/med/2253052800.jpg")!),
                      displayPrice: .init(header: "$9000", subheader: "Reserve met"),
                      buyNowPrice: "$9000")
        ]
    }
    
}
