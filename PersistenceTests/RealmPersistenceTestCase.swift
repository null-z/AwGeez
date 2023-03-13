//
//  RealmPersistenceTestCase.swift
//  PersistenceTests
//
//  Created by Tony Dэ on 13.03.2023.
//

import XCTest
import RealmSwift

class RealmPersistenceTestCase: XCTestCase {

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
}
