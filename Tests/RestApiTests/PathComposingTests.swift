//
//  PathComposingTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 06.01.2023.
//

import XCTest
import Swinject
@testable import RestApi

final class PathComposingTests: XCTestCase {
    
    var api: RestApi!
    var spyRequester: SpyRequester = SpyRequester()

    override func setUpWithError() throws {
        container.register(Requester.self) { _ in self.spyRequester }
        api = RestApi()
    }
    
    func testBaseUrl() throws {
        let request = Request(of: StubResponseModel.self, by: "") { _ in } failure: { _ in }

        api.handle(request: request)
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/")!)
    }
    
    // MARK: - Character
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
    
    // MARK: - Location
    func testLocationByIds() throws {
        api.location.get(by: [1, 2, 3, 4, 5]) { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/location/1,2,3,4,5")!)
    }
    
    func testLocationCount() throws {
        api.location.getCount { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/location/")!)
    }

    // MARK: - Episode
    func testEpisodeByIds() throws {
        api.episode.get(by: [1, 2, 3, 4, 5]) { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/episode/1,2,3,4,5")!)
    }
    
    func testEpisodeCount() throws {
        api.episode.getCount { _ in } failure: { _ in }
        
        let url = try XCTUnwrap(spyRequester.lastRequestUrl)
        XCTAssertEqual(url, URL(string: "https://rickandmortyapi.com/api/episode/")!)
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
