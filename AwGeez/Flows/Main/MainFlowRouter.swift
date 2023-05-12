//
//  MainFlowRouter.swift
//  AwGeez
//
//  Created by Tony Dэ on 24.04.2023.
//

import UIKit
import Model

final class MainFlowRouter {
    
    let window: UIWindow
    private var navigationController: MainFlowNavigationController!

    init(window: UIWindow) {
        self.window = window
    }
    
    func showRoot() {
        let characterListView = CharacterListAssembly().build(self)
        navigationController = MainFlowNavigationController(rootViewController: characterListView)
        window.rootViewController = navigationController
    }
    
    func showStatusBar() {
        navigationController.showStatusBar()
    }
}

extension MainFlowRouter: CharacterListRouter {
    func showCharacterDetails(for characterId: Character.ID) {
        let characterDetailsView = CharacterDetailsAssembly().build(self, characterId: characterId)
        navigationController.pushViewController(characterDetailsView, animated: true)
    }
}

extension MainFlowRouter: CharacterDetailsRouter {
    func showLocationDetails(for locationID: Model.Location.ID) {
    }
    
    func showEpisodeDetails(for episodeID: Model.Episode.ID) {
    }
}
