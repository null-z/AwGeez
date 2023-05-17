//
//  LocationDetailsAssembly.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//  
//

import UIKit
import Model

final class LocationDetailsAssembly {
    func build(_ router: LocationDetailsRouter, locationId: Location.ID) -> UIViewController {
        let interactor = LocationDetailsInteractor()
        
        let presenter = LocationDetailsPresenter(interactor: interactor, locationId: locationId)
        interactor.presenter = presenter
        
        let view = LocationDetailsView(presenter: presenter)
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
