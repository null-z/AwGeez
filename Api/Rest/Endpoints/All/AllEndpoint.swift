//
//  AllEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model

final class AllEndpoint: ApiAll {
    
    let characterEndpoint: CharacterEndpoint
    let locationEndpoint: LocationEndpoint
    let episodeEndpoint: EpisodeEndpoint
    
    init(characterEndpoint: CharacterEndpoint, locationEndpoint: LocationEndpoint, episodeEndpoint: EpisodeEndpoint) {
        self.characterEndpoint = characterEndpoint
        self.locationEndpoint = locationEndpoint
        self.episodeEndpoint = episodeEndpoint
    }
    
    public func get(completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>, failure: @escaping Failure) {
        self.getCounts(completion: { [weak self] counts in
            guard let self else { return }
            EntitiesFetcher(characterEndpoint: self.characterEndpoint,
                            locationEndpoint: self.locationEndpoint,
                            episodeEndpoint: self.episodeEndpoint)
                .getAll(by: counts, completion: completion, failure: failure)

        }, failure: failure)
    }
    
    func getCounts(completion: @escaping Completion<(characters: Count, locations: Count, episodes: Count)>, failure: @escaping Failure) {
        CountFetcher(characterEndpoint: characterEndpoint, locationEndpoint: locationEndpoint, episodeEndpoint: episodeEndpoint)
            .getCounts(completion: completion, failure: failure)
    }
}