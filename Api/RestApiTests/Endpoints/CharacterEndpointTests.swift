//
//  CharacterEndpointTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 06.01.2023.
//

import XCTest
import Macaroni
@testable import Api

final class CharacterEndpointTests: XCTestCase {
    
    var api: RestApi = RestApi()
    var mockRequester: MockRequester = MockRequester()

    override func setUpWithError() throws {
        container.register { () -> Requester in self.mockRequester }
    }
        
    func testGetByIds() throws {
        mockRequester.jsonData = MockedJsonData.characters

        let expectation = XCTestExpectation(description: "Response expectation")

        api.character.get(by: [1, 2, 3, 4, 5]) { characters in
            XCTAssertNotNil(characters.first)
            let rick = characters.first!
            XCTAssertEqual(rick.name, "Rick Sanchez")
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected failure")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCount() throws {
        mockRequester.jsonData = MockedJsonData.charactersFirstPage
        
        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.character.getCount { count in
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
