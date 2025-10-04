//
//  ListingsLoaderTests.swift
//  TradeMe-Hardeep
//
//  Created by Hardeep Singh on 04/10/25.
//

import XCTest
@testable import TradeMe_Hardeep

@MainActor
final class ListingsLoaderTests: XCTestCase {
    
    private func makeSUT(response: MockHTTPClient.ResponseType) -> (sut: ListingsLoader, client: MockHTTPClient) {
        let client = MockHTTPClient(responseType: response)
        let sut = RemoteListingsLoader(httpClient: client)
        return (sut, client)
    }
    
    func test_doesNotRequestData() async {
        let (_, client) = makeSUT(response: .error(AnyError.failed))
        XCTAssertTrue(client.calls.isEmpty, "Expected no network calls on init")
    }
    
    func test_load_requestsLatestListingsEndpoint() async throws {
        let (sut, client) = makeSUT(response: .success(makeListingResponse()))
        _ = try? await sut.execute()
        XCTAssertEqual(client.calls.count, 1, "Expected exactly one request")
        XCTAssertTrue(
            client.calls.first?.absoluteString.contains("https://api.tmsandbox.co.nz/v1/listings/latest.json") == true,
            "Expected request to 'latest listings' endpoint, got \(client.calls.first?.absoluteString ?? "nil")"
        )
    }
    
    func test_load_propagatesClientError() async {
        let (sut, _) = makeSUT(response: .error(AnyError.failed))
        
        do {
            _ = try await sut.execute()
            XCTFail("Expected to throw, but succeeded")
        } catch let error as AnyError {
            XCTAssertEqual(error, .failed, "Expected AnyError.failed")
        } catch {
            XCTFail("Expected AnyError.failed, got \(error)")
        }
    }
    
    func test_load_deliversDecodedListingsOnSuccess() async throws {
        let expectedCount = 20
        let response = makeListingResponse(count: expectedCount)
        let (sut, _) = makeSUT(response: .success(response))
        
        let items = try await sut.execute()
        
        XCTAssertEqual(items.count, expectedCount, "Expected \(expectedCount) items on successful load")
        for (remote, item) in zip(response.List, items) {
            XCTAssertEqual(remote.Title, item.title)
            XCTAssertEqual(remote.ListingId, item.id)
            XCTAssertEqual(remote.Region, item.region)
        }
    }
    
}

// MARK: - Test Support

enum AnyError: Error { case failed }

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

/// Safe mock: never force-casts silently; records called URLs.
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
