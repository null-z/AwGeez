//
//  SplashScreenPresenterTests.swift
//  AwGeezTests
//
//  Created by Tony Dэ on 26.04.2023.
//

import XCTest
@testable import AwGeez

final class SplashScreenPresenterTests: XCTestCase {
    
    private var router = MockRouter()
    private var interactor = MockInteractor()
    private var presenter: SplashScreenPresenter!
    private var view = MockView()

    override func setUpWithError() throws {
        presenter = SplashScreenPresenter(interactor: interactor)
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
    }
    
    func testUpdateSuccess() throws {
        interactor.isSuccessUpdate = true
        
        presenter.viewDidLoad()
        XCTAssertTrue(view.isLoadingAnimationStarted)
        
        XCTAssertTrue(view.isFinishAnimationStarted)
        XCTAssertTrue(router.isWillDisappear)
        
        presenter.finishAnimationDidEnd()
        XCTAssertTrue(router.isDidDisappear)
    }
    
    func testUpdateErrorThanReloadSuccess() throws {
        presenter.viewDidLoad()        
        XCTAssertFalse(view.isLoadingAnimationStarted)
        XCTAssertTrue(view.isReloadButtonVisible)
        XCTAssertFalse(view.errorMessage.isEmpty)
        
        interactor.isSuccessUpdate = true
        
        presenter.reloadButtonDidTapped()
        XCTAssertTrue(view.isLoadingAnimationStarted)
        XCTAssertFalse(view.isReloadButtonVisible)
        XCTAssertTrue(view.errorMessage.isEmpty)
        
        XCTAssertTrue(view.isFinishAnimationStarted)
        XCTAssertTrue(router.isWillDisappear)
        
        presenter.finishAnimationDidEnd()
        XCTAssertTrue(router.isDidDisappear)
    }
}

final private class MockView: SplashScreenViewInput {
    var isLoadingAnimationStarted = false
    var isReloadButtonVisible = false
    var errorMessage = ""
    var isFinishAnimationStarted = false
    
    func startLoadingAnimation() {
        isLoadingAnimationStarted = true
    }
    
    func stopLoadingAnimation() {
        isLoadingAnimationStarted = false
    }
    
    func showReloadButton() {
        isReloadButtonVisible = true
    }
    
    func hideReloadButton() {
        isReloadButtonVisible = false
    }
    
    func showError(_ message: String) {
        errorMessage = message
    }
    
    func startFinishAnimation() {
        isFinishAnimationStarted = true
    }
}

final private class MockInteractor: SplashScreenInteractorInput {
    var presenter: SplashScreenInteractorOutput!
    var isSuccessUpdate = false
    
    func updateDataIfNeeded() {
        if isSuccessUpdate {
            presenter.dataDidUpdated()
        } else {
            presenter.dataUpdateError(.badResponse)
        }
    }
}

final private class MockRouter: SplashScreenRouter {
    var isWillDisappear = false
    var isDidDisappear = false

    func willDisappear() {
        isWillDisappear = true
    }
    
    func didDisappear() {
        isDidDisappear = true
    }
}
