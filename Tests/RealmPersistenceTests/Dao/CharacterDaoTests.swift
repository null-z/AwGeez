//
//  CharacterDaoTests.swift
//  RealmPersistenceTests
//
//  Created by Tony Dэ on 12.03.2023.
//

import XCTest
import Model
@testable import RealmPersistence

final class CharacterDaoTests: RealmPersistenceTestCase {
    
    let dao = CharacterEntityDao()
    
    var example: Character!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        example = Model.Character.init(id: 40, name: "Farty", image: URL(string: "https://ya.ru")!, status: .alive, species: "human", type: "sapiens", gender: .male, origin: 1, location: nil, episodes: [1, 2, 10])
        
        let character1 = Model.Character(id: 1, name: "First", image: URL(string: "https://ya.ru")!, status: .alive, species: "", type: "", gender: .male, origin: nil, location: nil, episodes: [1])
        let character2 = Model.Character(id: 2, name: "Second", image: URL(string: "https://ya.ru")!, status: .alive, species: "", type: "", gender: .male, origin: nil, location: nil, episodes: [1])
                
        dao.write(entities: [example, character1, character2])
    }
    
    func testReadCount() throws {
        let count = dao.readCount()
        XCTAssertEqual(count, 3)
    }
    
    func testReadById() throws {
        let readedExample = dao.read(by: 40)
        XCTAssertEqual(example.id, readedExample.id)
        XCTAssertEqual(example.name, readedExample.name)
        XCTAssertEqual(example.image, readedExample.image)
        XCTAssertEqual(example.status, readedExample.status)
        XCTAssertEqual(example.species, readedExample.species)
        XCTAssertEqual(example.type, readedExample.type)
        XCTAssertEqual(example.gender, readedExample.gender)
        XCTAssertEqual(example.origin, readedExample.origin)
        XCTAssertEqual(example.location, readedExample.location)
        XCTAssertEqual(example.episodes, readedExample.episodes)
    }
    
    func testReadByIds() throws {
        let characters = dao.read(by: [1, 2, 40])
        XCTAssertEqual(characters.count, 3)
        XCTAssertEqual(characters[0].id, 1)
        XCTAssertEqual(characters[1].id, 2)
        XCTAssertEqual(characters[2].id, 40)
    }
}
