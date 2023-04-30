//
//  SplashScreenInteractorTests.swift
//  AwGeezTests
//
//  Created by Tony Dэ on 23.04.2023.
//

import XCTest
import Swinject
import Model
import Api
import Persistence
@testable import AwGeez

final class SplashScreenInteractorTests: XCTestCase {
    
    private var mockDefaults = MockDefaults()
    private var mockApi = MockApi()
    private var mockPersistence = MockPersistence()
    
    private var presenter = MockPresenter()
    private var interactor: SplashScreenInteractor!

    override func setUpWithError() throws {
        container.register(Defaults.self) { _ in self.mockDefaults }
        container.register(Api.self) { _ in self.mockApi }
        container.register(OverallPersistence.self) { _ in self.mockPersistence }
        interactor = SplashScreenInteractor()
        interactor.presenter = presenter
    }
    
    func testSkipUpdate() throws {
        mockDefaults.lastUpdateDate = Date()
        mockPersistence.isFilled = true
        
        interactor.updateDataIfNeeded()
        
        XCTAssertTrue(presenter.success)
        XCTAssertFalse(presenter.error)
        XCTAssertFalse(mockPersistence.dataWrited)
    }
    
    func testUpdateEmptyPersistence() throws {
        mockDefaults.lastUpdateDate = Date()
        mockPersistence.isFilled = false
        
        interactor.updateDataIfNeeded()
        
        XCTAssertTrue(presenter.success)
        XCTAssertFalse(presenter.error)
        XCTAssertTrue(mockPersistence.dataWrited)
    }

    func testSuccessUpdate() throws {
        mockDefaults.lastUpdateDate = Date(timeIntervalSince1970: 0)
        
        interactor.updateDataIfNeeded()
        
        XCTAssertTrue(presenter.success)
        XCTAssertFalse(presenter.error)
        XCTAssertTrue(mockPersistence.dataWrited)
    }
    
    func testErrorUpdate() throws {
        mockDefaults.lastUpdateDate = nil
        mockApi.success = false
        
        interactor.updateDataIfNeeded()
        
        XCTAssertFalse(presenter.success)
        XCTAssertTrue(presenter.error)
        XCTAssertFalse(mockPersistence.dataWrited)
    }
}

final private class MockPresenter: SplashScreenInteractorOutput {
    var success = false
    var error = false
    
    func dataDidUpdated() {
        success = true
    }
    
    func dataUpdateError(_ error: ApiError) {
        self.error = true
    }
}

final private class MockDefaults: Defaults {
    var lastUpdateDate: Date?
}

final private class MockApi: Api {
    var success = true
    
    func getAll(completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>, failure: @escaping Failure) {
        if success {
            completion(([], [], []))
        } else {
            failure(.badResponse)
        }
    }
}

final private class MockPersistence: OverallPersistence {
    var dataWrited = false
    var isFilled: Bool = false
    
    func fillWith(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode]) {
        dataWrited = true
    }
    func clear() { }
}
