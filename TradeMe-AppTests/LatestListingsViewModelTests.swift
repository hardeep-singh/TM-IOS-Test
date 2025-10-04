//
//  LatestListingsViewModelTests.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 04/10/25.
//

import XCTest
@testable import TradeMe_Hardeep

@MainActor
final class LatestListingsViewModelTests: XCTestCase {
    
    func test_reserveStateLabel_returnsAcceptedValues() async {
        let listings: [Listing] = [makeListing(id: 0, reserveState: .none),
                                   makeListing(id: 1, reserveState: .met),
                                   makeListing(id: 2, reserveState: .notMet),
                                   makeListing(id: 3, reserveState: .notApplicable)]
        let (sut, _) = makeSUT(result: .success(listings))
        await sut.fetchListings()
        
        XCTAssertEqual(sut.listings[0].displayPrice?.subheader, "No Reserve")
        XCTAssertEqual(sut.listings[1].displayPrice?.subheader, "Reserve Met")
        XCTAssertEqual(sut.listings[2].displayPrice?.subheader, "Reserve Not Met")
        XCTAssertNil(sut.listings[3].displayPrice?.subheader)
        
    }
    
    func test_buyNow_returnsAcceptedValues() async {
        let listings: [Listing] = [makeListing(id: 0, buyNowPrice: nil),
                                   makeListing(id: 1, buyNowPrice: 11.1),
                                   makeListing(id: 2, buyNowPrice: 11.1111),
                                   makeListing(id: 3, buyNowPrice: 01.00002)]
        let (sut, _) = makeSUT(result: .success(listings))
        await sut.fetchListings()
        
        XCTAssertNil(sut.listings[0].buyNowPrice)
        XCTAssertTrue(sut.listings[1].buyNowPrice?.contains("11.10") == true)
        XCTAssertTrue(sut.listings[2].buyNowPrice?.contains("11.11") == true)
        XCTAssertTrue(sut.listings[3].buyNowPrice?.contains("1.00") == true)
    }
    
    func test_fetchListings_error_clearsItems_andSetsAlert() async {
        
        let (sut, _) = makeSUT(result: .failure(AnyError.failed))
        sut.listings = [makeUIOPlaceholder()]
        
        await sut.fetchListings()
        
        XCTAssertEqual(sut.listings.count, 0, "Expected items cleared on error")
        guard case let .some(.error(message)) = sut.alertItem else {
            return XCTFail("Expected .error alert")
        }
        XCTAssertTrue(message.contains("AnyError"))
    }
    
}

// MARK: - Test doubles & helpers

private final class MockListingLoader: ListingsLoader {
    enum Result {
        case success([Listing])
        case failure(Error)
    }
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func execute() async throws -> [Listing] {
        switch result {
        case .success(let items): return items
        case .failure(let error): throw error
        }
    }
    
}

private func makeSUT(result: MockListingLoader.Result) -> (sut: LatestListingsViewModel, client: ListingsLoader) {
    let loader = MockListingLoader(result: result)
    let vm = LatestListingsViewModel(listingsLoader: loader)
    return (vm, loader)
}

private func makeListing(id: Int,
                         title: String? = nil,
                         region: String? = nil,
                         images: [String] = [],
                         pictureHref: String? = nil,
                         isClassified: Bool = false,
                         buyNowPrice: Decimal? = nil,
                         priceDisplay: String = "",
                         reserveState: ListingReserveState = .notApplicable) -> Listing {
    return Listing(id: id,
                   title: title,
                   region: region,
                   buyNowPrice: buyNowPrice,
                   reserveState: reserveState,
                   priceDisplay: priceDisplay,
                   pictureHref: pictureHref,
                   isClassified: isClassified,
                   images: images)
}

private func makeUIOPlaceholder() -> UIOListing {
    UIOListing(
        id: 999,
        location: "X",
        title: "X",
        thumbnil: .local(""),
        displayPrice: .init(header: "$0", subheader: nil),
        buyNowPrice: nil
    )
}
