//
//  AllEndpointTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 12.01.2023.
//

import XCTest
import Macaroni
@testable import Api

final class AllEndpointTests: XCTestCase {
    
    var all: AllEndpoint!
    let stubRequesHandler = StubRequesHandler()
    
    override func setUpWithError() throws {
        let characterEndpointMock = MockCharacterEndpoint(requestHandler: stubRequesHandler)
        let locationEndpointMock = MockLocationEndpoint(requestHandler: stubRequesHandler)
        let episodeEndpointMock = MockEpisodeEndpoint(requestHandler: stubRequesHandler)
        all = AllEndpoint(characterEndpoint: characterEndpointMock, locationEndpoint: locationEndpointMock, episodeEndpoint: episodeEndpointMock)
    }
    
    func testGetCounts() throws {
        let expectation = XCTestExpectation(description: "Response expectation")

        all.getCounts { (characters: Count, locations: Count, episodes: Count) in
            XCTAssertEqual(characters, 500)
            XCTAssertEqual(locations, 50)
            XCTAssertEqual(episodes, 10)
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
    
}

class StubRequesHandler: RequestHandler {
    func handle<R>(request: Request<R>) where R: ResponseModel {
    }
}

final class MockCharacterEndpoint: CharacterEndpoint {
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(500)
    }
}

final class MockLocationEndpoint: LocationEndpoint {
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(50)
    }
}

final class MockEpisodeEndpoint: EpisodeEndpoint {
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(10)
    }
}
