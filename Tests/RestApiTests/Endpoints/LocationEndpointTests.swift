//
//  LocationEndpointTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 11.01.2023.
//

import XCTest
import Macaroni
@testable import RestApi

final class LocationEndpointTests: XCTestCase {
    
    var api: RestApi = RestApi()
    var mockRequester: MockRequester = MockRequester()

    override func setUpWithError() throws {
        container.register { () -> Requester in self.mockRequester }
    }
        
    func testGetByIds() throws {
        mockRequester.jsonData = MockedJsonData.locations

        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.location.get(by: [1, 2, 3, 4, 5]) { locations in
            XCTAssertNotNil(locations.first)
            let earth = locations.first!
            XCTAssertEqual(earth.name, "Earth (C-137)")
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected failure")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCount() throws {
        mockRequester.jsonData = MockedJsonData.locationsFirstPage
        
        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.location.getCount { count in
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
