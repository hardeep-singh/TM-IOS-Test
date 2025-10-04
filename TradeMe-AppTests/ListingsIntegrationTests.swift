//
//  ListingsIntegrationTests.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 04/10/25.
//

import XCTest
import Combine
@testable import TradeMe_Hardeep

@MainActor
final class ListingsIntegrationTests: XCTestCase {
    
    func test_returnListings_OnSuccess() async {
        let (sut, _) = makeSUT(response: .success(makeListingResponse()))
        await sut.fetchListings()
        XCTAssertEqual(sut.listings.count, 20)
        XCTAssertNil(sut.alertItem)
    }
    
    func test_returnError_OnFailed() async {
        let (sut, _) = makeSUT(response: .error(AnyError.failed))
        await sut.fetchListings()
        XCTAssertEqual(sut.listings.count, 0)
        XCTAssertNotNil(sut.alertItem)
    }
    
    private func makeSUT(response: MockHTTPClient.ResponseType) -> (sut: LatestListingsViewModel, client: HTTPClient) {
        let client =  MockHTTPClient(responseType: response)
        let loader = RemoteListingsLoader(httpClient: client)
        let sut = LatestListingsViewModel(listingsLoader: loader)
        return (sut, client)
    }
    
}

private func makeListingResponse(count: Int = 20) -> ListingMapper.RemoteListingResponse {
    let list: [ListingMapper.RemoteListing] = (0..<count).map { i in
            .init(
                ListingId: i,
                Title: "Title: \(i)",
                Region: "Region: \(i)",
                ReserveState: .None,
                BuyNowPrice: 10000.0,
                PriceDisplay: "Price Display \(i)",
                PictureHref: "http://example.com/\(i).jpg",
                IsClassified: false,
                PhotoUrls: ["http://example.com/\(i)_1.jpg"]
            )
    }
    return .init(TotalCount: 100, Page: 1, PageSize: count, List: list)
}

private final class MockHTTPClient: HTTPClient {
    
    enum ResponseType {
        case success(ListingMapper.RemoteListingResponse)
        case error(Error)
    }
    
    let responseType: ResponseType
    private(set) var calls: [URL] = []
    
    init(responseType: ResponseType) {
        self.calls = []
        self.responseType = responseType
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        calls.append(url)
        
        switch responseType {
        case .error(let error):
            throw error
            
        case .success(let payload):
            guard let typed = payload as? T else {
                fatalError("MockHTTPClient.get<T>: Requested \(T.self) but mock holds \(type(of: payload))")
            }
            return typed
        }
    }
}
