//
//  EpisodeDaoTests.swift
//  PersistenceTests
//
//  Created by Tony Dэ on 13.03.2023.
//

import XCTest
import RealmSwift
import Model
@testable import Persistence

final class EpisodeDaoTests: XCTestCase {

    let dao = EpisodeEntityDao()
    
    var example: Episode!

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        XCTAssertTrue(try! Realm().isEmpty)

        example = Model.Episode(id: 999, season: 99, number: 1, name: "Return of Mr. Poopybutthole", airDate: Date(), characters: [40, 1])

        let episode1 = Model.Episode(id: 1, season: 1, number: 1, name: "First", airDate: Date(), characters: [1])
        let episode2 = Model.Episode(id: 2, season: 1, number: 2, name: "Second", airDate: Date(), characters: [2])
        
        dao.write(entities: [example, episode1, episode2])
        
        XCTAssertFalse(try! Realm().isEmpty)
    }

    func testReadById() throws {
        let readedExample = dao.read(by: 999)
        XCTAssertEqual(example.id, readedExample.id)
        XCTAssertEqual(example.season, readedExample.season)
        XCTAssertEqual(example.number, readedExample.number)
        XCTAssertEqual(example.name, readedExample.name)
        XCTAssertEqual(example.airDate, readedExample.airDate)
        XCTAssertEqual(example.characters, readedExample.characters)
    }
    
    func testReadByIds() throws {
        let episodes = dao.read(by: [1, 2, 999])
        XCTAssertEqual(episodes.count, 3)
        XCTAssertEqual(episodes[0].id, 1)
        XCTAssertEqual(episodes[1].id, 2)
        XCTAssertEqual(episodes[2].id, 999)
    }
}
