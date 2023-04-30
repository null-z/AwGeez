//
//  RealmPersistenceTestCase.swift
//  RealmPersistenceTests
//
//  Created by Tony Dэ on 13.03.2023.
//

import XCTest
@testable import RealmPersistence
class RealmPersistenceTestCase: XCTestCase {

    override func setUpWithError() throws {
        RealmPersistence.configureInMemory(name: self.name)
    }
}
