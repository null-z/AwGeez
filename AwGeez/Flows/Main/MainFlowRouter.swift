//
//  MainFlowRouter.swift
//  AwGeez
//
//  Created by Tony Dэ on 24.04.2023.
//

import UIKit

final class MainFlowRouter {
    
    let window: UIWindow
    private var navigationController: MainFlowNavigationController!

    init(window: UIWindow) {
        self.window = window
    }
    
    func showRoot() {
        let characterListView = CharacterListAssembly().build(self)
        navigationController = MainFlowNavigationController(rootViewController: characterListView)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
    }
    
    func showStatusBar() {
        navigationController.showStatusBar()
    }
}

extension MainFlowRouter: CharacterListRouter {
    
}
