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
    
    var api: RestApi!
    var mockRequester: MockRequester!

    override func setUpWithError() throws {
        self.api = RestApi()
        
        self.mockRequester = MockRequester()
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

        wait(for: [expectation], timeout: 3)
    }
    
    func testGetCount() throws {
        mockRequester.jsonData = MockedJsonData.charactersPage
        
        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.character.getCount { response in
            XCTAssertEqual(825, response)
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

}

class MockRequester: Requester {
    var jsonData: Data!
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        let responseModel = try? JSONDecoder().decode(R.self, from: jsonData)
        guard let responseModel = responseModel else {
            XCTFail("Cannot convert to model")
            return
        }
        request.completion(responseModel)
    }
}
