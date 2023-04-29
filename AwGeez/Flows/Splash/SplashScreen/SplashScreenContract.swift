//
//  SplashScreenContract.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.04.2023.
//

import Foundation
import enum Api.ApiError

protocol SplashScreenRouter: AnyObject {
    func willDisappear()
    func didDisappear()
}

protocol SplashScreenInteractorInput: AnyObject {
    func updateDataIfNeeded()
}

protocol SplashScreenInteractorOutput: AnyObject {
    func dataDidUpdated()
    func dataUpdateError(_ error: ApiError)
}

protocol SplashScreenViewInput: AnyObject {
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func showReloadButton()
    func hideReloadButton()
    func showError(_ message: String)
    func startFinishAnimation()
}

protocol SplashScreenViewOutput: AnyObject {
    func viewDidLoad()
    func reloadButtonDidTapped()
    func finishAnimationDidEnd()
}
