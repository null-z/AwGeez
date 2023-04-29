//
//  CharacterListAssembly.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//  
//

import UIKit

final class CharacterListAssembly {
    func build(_ router: CharacterListRouter) -> UIViewController {
        let interactor = CharacterListInteractor()
        
        let presenter = CharacterListPresenter(interactor: interactor)
        interactor.presenter = presenter
        
        let view = CharacterListView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
