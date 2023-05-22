//
//  EpisodeDetailsAssembly.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//  
//

import UIKit
import Model

final class EpisodeDetailsAssembly {
    func build(_ router: EpisodeDetailsRouter, episodeId: Episode.ID) -> UIViewController {
        let interactor = EpisodeDetailsInteractor()
        
        let presenter = EpisodeDetailsPresenter(interactor: interactor, episodeId: episodeId)
        interactor.presenter = presenter
        
        let view = EpisodeDetailsView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
