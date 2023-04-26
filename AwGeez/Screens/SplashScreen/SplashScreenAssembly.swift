//
//  SplashScreenAssembly.swift
//  AwGeez
//
//  Created by Tony Dэ on 24.04.2023.
//

import UIKit

final class SplashScreenAssembly {
    func build(_ router: SplashScreenRouter) -> UIViewController {
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter(interactor: interactor)
        interactor.presenter = presenter
        let view = SplashScreenView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        return view
    }
}
