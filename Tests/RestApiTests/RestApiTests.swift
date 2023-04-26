//
//  RestApiTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 06.01.2023.
//

import XCTest
import Api
@testable import RestApi

final class RestApiTests: XCTestCase {
    
    var api: RestApi!
    let stubRequesHandler = StubRequesHandler()
    
    override func setUpWithError() throws {
        let characterEndpointMock = MockCharacterEndpoint(requestHandler: stubRequesHandler)
        let locationEndpointMock = MockLocationEndpoint(requestHandler: stubRequesHandler)
        let episodeEndpointMock = MockEpisodeEndpoint(requestHandler: stubRequesHandler)
        api = RestApi(character: characterEndpointMock, location: locationEndpointMock, episode: episodeEndpointMock)
    }
    
    func testGetAll() throws {
        let expectation = XCTestExpectation(description: "Response expectation")
        
        api.getAll { entities in
            XCTAssertEqual(entities.characters.count, 5)
            XCTAssertEqual(entities.locations.count, 5)
            XCTAssertEqual(entities.episodes.count, 5)
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Unexpected error")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetCounts() throws {
        let expectation = XCTestExpectation(description: "Response expectation")

        api.getCounts { (characters: Count, locations: Count, episodes: Count) in
            XCTAssertEqual(characters, 5)
            XCTAssertEqual(locations, 5)
            XCTAssertEqual(episodes, 5)
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

import Model

final class MockCharacterEndpoint: CharacterEndpoint {
    override func get(by ids: [Character.ID], completion: @escaping ([Character]) -> Void, failure: @escaping Failure) {
        let characters = try! JSONDecoder().decode([Model.Character].self, from: MockedJsonData.characters)
        completion(characters)
    }
    
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(5)
    }
}

final class MockLocationEndpoint: LocationEndpoint {
    override func get(by ids: [Location.ID], completion: @escaping ([Location]) -> Void, failure: @escaping Failure) {
        let locations = try! JSONDecoder().decode([Model.Location].self, from: MockedJsonData.locations)
        completion(locations)
    }
    
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(5)
    }
}

final class MockEpisodeEndpoint: EpisodeEndpoint {
    override func get(by ids: [Episode.ID], completion: @escaping ([Episode]) -> Void, failure: @escaping Failure) {
        let episodes = try! JSONDecoder().decode([Model.Episode].self, from: MockedJsonData.episodes)
        completion(episodes)
    }
    
    override func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        completion(5)
    }
}
