//
//  ModelsDecodingTests.swift
//  RestApiTests
//
//  Created by Tony Dэ on 09.01.2023.
//

import XCTest
import Model
@testable import Api

final class ModelsDecodingTests: XCTestCase {
    
    func testPaginatedResponseDecoding() throws {
        let jsonData = MockedJsonData.charactersPage
        XCTAssertNoThrow(try JSONDecoder().decode(PaginatedResponse.self, from: jsonData))
    }
    
    func testCharacterDecoding() throws {
        let jsonData = MockedJsonData.character
        XCTAssertNoThrow(try JSONDecoder().decode(Model.Character.self, from: jsonData))
    }

    func testCharactersDecoding() throws {
        let jsonData = MockedJsonData.characters
        XCTAssertNoThrow(try JSONDecoder().decode([Model.Character].self, from: jsonData))
    }
}
