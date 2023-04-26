//
//  DefaultsTests.swift
//  AwGeezTests
//
//  Created by Tony Dэ on 23.04.2023.
//

import XCTest
@testable import AwGeez

final class DefaultsTests: XCTestCase {
    
    private var defaults: Defaults!

    override func setUpWithError() throws {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        defaults = userDefaults
    }
    
    func testLastUpdateDate() throws {
        let zero = Date.init(timeIntervalSince1970: 0)
        
        XCTAssertEqual(defaults.lastUpdateDate, zero)
        
        let now = Date()
        defaults.lastUpdateDate = now
        
        let result = try XCTUnwrap(defaults.lastUpdateDate)
        XCTAssertEqual(result.timeIntervalSince1970, now.timeIntervalSince1970, accuracy: 0.001)
    }
}
