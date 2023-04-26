//
//  EpisodeEndpointTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 12.01.2023.
//

import XCTest
import Swinject
@testable import RestApi

final class EpisodeEndpointTests: XCTestCase {
    
    var api: RestApi!
    var mockRequester: MockRequester = MockRequester()

    override func setUpWithError() throws {
        container.register(Requester.self) { _ in self.mockRequester }
        api = RestApi()
    }
        
    func testGetByIds() throws {
        mockRequester.jsonData = MockedJsonData.episodes

        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.episode.get(by: [1, 2, 3, 4, 5]) { episodes in
            XCTAssertNotNil(episodes.first)
            let first = episodes.first!
            XCTAssertEqual(first.name, "Pilot")
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected failure")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCount() throws {
        mockRequester.jsonData = MockedJsonData.episodesFirstPage
        
        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.episode.getCount { count in
            XCTAssertGreaterThan(count, 0)
            XCTAssertLessThan(count, 1000)
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

}
