//
//  CharacterListInteractor.swift
//  AwGeez
//
//  Created by Tony Dэ on 26.04.2023.
//  
//

import Foundation
import Swinject
import Model
import Persistence

final class CharacterListInteractor {
    
    weak var presenter: CharacterListInteractorOutput?
    
    private var characterDao: any CharacterDao = container.resolve((any CharacterDao).self)!
    private var episodeDao: any EpisodeDao = container.resolve((any EpisodeDao).self)!
}

extension CharacterListInteractor: CharacterListInteractorInput {
    
    func numberOfCharacters() -> Int {
        characterDao.readCount()
    }
    
    func character(for id: Character.ID) -> Character {
        characterDao.read(by: id)
    }
    
    func episode(for id: Episode.ID) -> Episode {
        episodeDao.read(by: id)
    }
}
