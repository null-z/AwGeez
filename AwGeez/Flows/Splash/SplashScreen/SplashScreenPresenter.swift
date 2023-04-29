//
//  SplashScreenPresenter.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.04.2023.
//

import Foundation
import enum Api.ApiError

final class SplashScreenPresenter {
    
    weak var router: SplashScreenRouter?
    weak var view: SplashScreenViewInput?
    private let interactor: SplashScreenInteractorInput
    
    init(interactor: SplashScreenInteractorInput) {
        self.interactor = interactor
    }
}

extension SplashScreenPresenter: SplashScreenViewOutput {
    
    func viewDidLoad() {
        view?.startLoadingAnimation()
        interactor.updateDataIfNeeded()
    }
    
    func reloadButtonDidTapped() {
        view?.showError("")
        view?.hideReloadButton()
        viewDidLoad()
    }
    
    func finishAnimationDidEnd() {
        router?.didDisappear()
    }
}

extension SplashScreenPresenter: SplashScreenInteractorOutput {
    
    func dataDidUpdated() {
        router?.willDisappear()
        view?.startFinishAnimation()
    }
    
    func dataUpdateError(_ error: ApiError) {
        let message: String
        switch error {
        case .badResponse: message = R.string.localizable.badResponse_message()
        case .badConnection: message = R.string.localizable.badConnection_message()
        }
        view?.showError(message)
        view?.stopLoadingAnimation()
        view?.showReloadButton()
    }
}
