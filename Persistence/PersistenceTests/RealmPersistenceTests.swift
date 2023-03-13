//
//  RealmPersistenceTests.swift
//  PersistenceTests
//
//  Created by Tony Dэ on 13.03.2023.
//

import XCTest
import RealmSwift
import Model
@testable import Persistence

final class RealmPersistenceTests: RealmPersistenceTestCase {
    
    let persistence: Persistence = RealmPersistence()
    
    let character = Model.Character(id: 1, name: "Rick Skwanchez", image: URL(string: "https://ya.ru")!, status: .alive, species: "", type: nil, gender: .male, origin: nil, location: nil, episodes: [1])
    let location = Model.Location(id: 1, name: "Garage", type: "", dimension: "", residents: [1])
    let episode = Model.Episode(id: 1, season: 1, number: 1, name: "Beginning", airDate: Date(), characters: [1])
        
    func testIsFilled() throws {
        persistence.fillWith(characters: [character], locations: [location], episodes: [episode])
        XCTAssertTrue(persistence.isFilled)
    }
    
    func testIsNotFilled() throws {
        persistence.character.write(entities: [character])
        XCTAssertFalse(persistence.isFilled)
    }
    
    func testIsEmpty() throws {
        XCTAssertFalse(persistence.isFilled)
    }
        
    func testClear() throws {
        persistence.fillWith(characters: [character], locations: [location], episodes: [episode])
        persistence.clear()
        XCTAssertFalse(persistence.isFilled)
    }
}
