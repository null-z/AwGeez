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
    var spyRequester: SpyRequester!

    override func setUpWithError() throws {
        self.spyRequester = SpyRequester()
        container.register { () -> Requester in self.spyRequester }
        
        self.api = RestApi()
    }
    
    func testBaseUrl() throws {
        api.handleRequest(of: StubResponseModel.self, with: "") { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api")!)
    }
    
    func testCharactersByIds() throws {
        api.character.get(by: [1, 2, 3, 4, 5]) { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/character/1,2,3,4,5")!)
    }
    
    func testCharacterCount() throws {
        api.character.getCount { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/character/")!)
    }

}

struct StubResponseModel: ResponseModel { }

class SpyRequester: Requester {
    
    var lastRequestUrl: URL?
    
    func get<R>(_ type: R.Type, url: URL, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        self.lastRequestUrl = url
    }
}
