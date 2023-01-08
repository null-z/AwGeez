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
        
        api.character.getCount { result in
            if case Result.success(let response) = result {
                XCTAssertEqual(825, response)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }

}

class MockRequester: Requester {
    var jsonData: Data!
    
    func get<R>(_ type: R.Type, url: URL, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        let responseModel = try? JSONDecoder().decode(R.self, from: jsonData)
        guard let responseModel = responseModel else {
            XCTFail("Cannot convert to model")
            return
        }
        completion(.success(responseModel))
    }
}
