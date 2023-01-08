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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetCount() throws {
        mockRequester.jsonData = MockedJsonData.characters
        
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
