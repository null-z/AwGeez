//
//  ModelsDecodingTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 09.01.2023.
//

import XCTest
import Model
@testable import RestApi

final class ModelsDecodingTests: XCTestCase {
    
    // MARK: - Character
    func testCharacterDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(Model.Character.self, from: MockedJsonData.character))
    }

    func testCharactersDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode([Model.Character].self, from: MockedJsonData.characters))
    }
    
    func testCharacterPaginatedResponseDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(PaginatedResponse.self, from: MockedJsonData.charactersFirstPage))
    }
    
    // MARK: - Location
    func testLocationDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(Model.Location.self, from: MockedJsonData.location))
    }
    
    func testLocationsDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode([Model.Location].self, from: MockedJsonData.locations))
    }
    
    func testLocationPaginatedResponseDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(PaginatedResponse.self, from: MockedJsonData.locationsFirstPage))
    }
    
    // MARK: - Episode
    func testEpisodeDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(Model.Episode.self, from: MockedJsonData.episode))
    }
    
    func testEpisodesDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode([Model.Episode].self, from: MockedJsonData.episodes))
    }
    
    func testEpisodePaginatedResponseDecoding() throws {
        XCTAssertNoThrow(try JSONDecoder().decode(PaginatedResponse.self, from: MockedJsonData.episodesFirstPage))
    }
}
