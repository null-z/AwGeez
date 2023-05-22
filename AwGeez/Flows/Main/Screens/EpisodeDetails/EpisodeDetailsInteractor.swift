//
//  EpisodeDetailsInteractor.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.05.2023.
//  
//

import Foundation
import Model
import Persistence

final class EpisodeDetailsInteractor {
    
    private var episodeDao: any EpisodeDao = container.resolve((any EpisodeDao).self)!
    private var characterDao: any CharacterDao = container.resolve((any CharacterDao).self)!
    
    weak var presenter: EpisodeDetailsInteractorOutput?
    
}

extension EpisodeDetailsInteractor: EpisodeDetailsInteractorInput {
    func episode(for id: Episode.ID) -> Episode {
        episodeDao.read(by: id)
    }
    
    func characters(for ids: [Character.ID]) -> [Character] {
        characterDao.read(by: ids)
    }
}
