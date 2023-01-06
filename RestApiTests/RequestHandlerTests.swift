//
//  RequestHandlerTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 06.01.2023.
//

import XCTest
import Macaroni
@testable import Api

final class RequestHandlerTests: XCTestCase {
    
    var api: RestApi!
    var mockRequester: MockRequester!

    override func setUpWithError() throws {
        self.mockRequester = MockRequester()
        container.register { () -> Requester in self.mockRequester }
        
        self.api = RestApi()
    }
    
    func testBaseUrl() throws {
        api.handleRequest(of: StubResponseModel.self, with: "") { _ in }
        
        let url = try XCTUnwrap(mockRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api")!)
    }
    
    func testCharacterById() throws {
        api.character.get(by: [1, 2, 3, 4, 5]) { _ in }
        
        let url = try XCTUnwrap(mockRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/character/1,2,3,4,5")!)
    }

}

struct StubResponseModel: ResponseModel { }

class MockRequester: Requester {
    
    var lastRequestUrl: URL?
    
    func get<R>(_ type: R.Type, url: URL, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        self.lastRequestUrl = url
    }
}
