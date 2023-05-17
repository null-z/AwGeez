//
//  LocationDetailsInteractor.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//  
//

import Foundation
import Model
import Persistence

final class LocationDetailsInteractor {
    
    private var characterDao: any CharacterDao = container.resolve((any CharacterDao).self)!
    private var locationDao: any LocationDao = container.resolve((any LocationDao).self)!
    
    weak var presenter: LocationDetailsInteractorOutput?
}

extension LocationDetailsInteractor: LocationDetailsInteractorInput {
    
    func location(for id: Location.ID) -> Location {
        locationDao.read(by: id)
    }
    
    func characters(for ids: [Character.ID]) -> [Character] {
        characterDao.read(by: ids)
    }
}
