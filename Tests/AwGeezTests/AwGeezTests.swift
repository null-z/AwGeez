//
//  AwGeezTests.swift
//  AwGeezTests
//
//  Created by Tony Dэ on 29.12.2022.
//

import XCTest
@testable import AwGeez

final class AwGeezTests: XCTestCase {
    
    func testResources() throws {
        XCTAssertNoThrow(try R.validate())
    }
    
    func testProcessInfoIsTestRun() throws {
        XCTAssertTrue(ProcessInfo.processInfo.isTestRun)
    }
}
