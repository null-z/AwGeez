//
//  LocationDaoTests.swift
//  RealmPersistenceTests
//
//  Created by Tony Dэ on 13.03.2023.
//

import XCTest
import Model
@testable import RealmPersistence

final class LocationDaoTests: RealmPersistenceTestCase {
    
    let dao = LocationEntityDao()
    
    var example: Location!

    override func setUpWithError() throws {
        try super.setUpWithError()

        example = Model.Location(id: 20, name: "Earth", type: "planet", dimension: "A-000", residents: [1, 2, 40])
        
        let location1 = Model.Location(id: 1, name: "First", type: "", dimension: "", residents: [1])
        let location2 = Model.Location(id: 2, name: "Second", type: "", dimension: "", residents: [1])
                
        dao.write(entities: [example, location1, location2])
    }
    
    func testReadCount() throws {
        let count = dao.readCount()
        XCTAssertEqual(count, 3)
    }

    func testReadById() throws {
        let readedExample = dao.read(by: 20)
        XCTAssertEqual(example.id, readedExample.id)
        XCTAssertEqual(example.name, readedExample.name)
        XCTAssertEqual(example.type, readedExample.type)
        XCTAssertEqual(example.dimension, readedExample.dimension)
        XCTAssertEqual(example.residents, readedExample.residents)
    }
    
    func testReadByIds() throws {
        let locations = dao.read(by: [1, 2, 20])
        XCTAssertEqual(locations.count, 3)
        XCTAssertEqual(locations[0].id, 1)
        XCTAssertEqual(locations[1].id, 2)
        XCTAssertEqual(locations[2].id, 20)
    }
}
