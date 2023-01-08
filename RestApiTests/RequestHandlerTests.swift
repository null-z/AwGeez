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
        let request = Request(of: StubResponseModel.self, by: "") { _ in
        } failure: { _ in
        }

        api.handle(request: request)
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/")!)
    }
    
    func testCharactersByIds() throws {
        api.character.get(by: [1, 2, 3, 4, 5]) { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/character/1,2,3,4,5")!)
    }
    
    func testCharacterCount() throws {
        api.character.getCount { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/character/")!)
    }

}

struct StubResponseModel: ResponseModel { }

class SpyRequester: Requester {
    
    var lastRequestUrl: URL?
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        guard let url = URL(string: request.path) else { return }
        self.lastRequestUrl = url
    }
}
