//
//  CharacterDetailsAssembly.swift
//  AwGeez
//
//  Created by Tony Dэ on 10.05.2023.
//  
//

import UIKit
import Model

final class CharacterDetailsAssembly {
    func build(_ router: CharacterDetailsRouter, characterId: Character.ID) -> UIViewController {
        let interactor = CharacterDetailsInteractor()
        
        let presenter = CharacterDetailsPresenter(interactor: interactor, characterId: characterId)
        interactor.presenter = presenter
        
        let view = CharacterDetailsView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
