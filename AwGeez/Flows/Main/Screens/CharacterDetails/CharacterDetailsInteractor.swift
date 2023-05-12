//
//  CharacterDetailsInteractor.swift
//  AwGeez
//
//  Created by Tony Dэ on 10.05.2023.
//  
//

import Foundation
import Model
import Persistence

final class CharacterDetailsInteractor {
    
    weak var presenter: CharacterDetailsInteractorOutput?
    
    private var characterDao: any CharacterDao = container.resolve((any CharacterDao).self)!
    private var locationDao: any LocationDao = container.resolve((any LocationDao).self)!
    private var episodeDao: any EpisodeDao = container.resolve((any EpisodeDao).self)!
}

extension CharacterDetailsInteractor: CharacterDetailsInteractorInput {
    func character(for id: Character.ID) -> Character {
        characterDao.read(by: id)
    }
    
    func location(for id: Location.ID) -> Location {
        locationDao.read(by: id)
    }
    
    func episodes(for ids: [Episode.ID]) -> [Episode] {
        episodeDao.read(by: ids)
    }
}
