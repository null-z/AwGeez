//
//  EntitiesFetcher.swift
//  Api
//
//  Created by Tony Dэ on 13.01.2023.
//

import Foundation
import Model

final class EntitiesFetcher {
    
    private let characterEndpoint: CharacterEndpoint
    private let locationEndpoint: LocationEndpoint
    private let episodeEndpoint: EpisodeEndpoint
    
    init(characterEndpoint: CharacterEndpoint, locationEndpoint: LocationEndpoint, episodeEndpoint: EpisodeEndpoint) {
        self.characterEndpoint = characterEndpoint
        self.locationEndpoint = locationEndpoint
        self.episodeEndpoint = episodeEndpoint
    }
    
    private var dispatchGroup = DispatchGroup()
    
    private var characters: [Model.Character]?
    private var locations: [Model.Location]?
    private var episodes: [Model.Episode]?
    
    private var error: ApiError?

    func getAll(by counts: (characters: Count, locations: Count, episodes: Count),
                completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>,
                failure: @escaping Failure) {
        
        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()
        
        let charactersIds = ids(forCount: counts.characters)
        characterEndpoint.get(by: charactersIds, completion: { characters in
            self.characters = characters
            self.dispatchGroup.leave()
        }, failure: saveErrorAndLeave(_:))
        
        let locationsIds = ids(forCount: counts.locations)
        locationEndpoint.get(by: locationsIds, completion: { locations in
            self.locations = locations
            self.dispatchGroup.leave()
        }, failure: saveErrorAndLeave(_:))
        
        let episodesIds = ids(forCount: counts.episodes)
        episodeEndpoint.get(by: episodesIds, completion: { episodes in
            self.episodes = episodes
            self.dispatchGroup.leave()
        }, failure: saveErrorAndLeave(_:))
        
        dispatchGroup.notify(queue: .main, execute: {
            if let characters = self.characters,
               let locations = self.locations,
               let episodes = self.episodes {
                completion((characters, locations, episodes))
            } else {
                let error = self.error ?? .badResponse
                failure(error)
            }
        })
    }
        
    private func ids(forCount count: Count) -> [Model.Entity.ID] {
        return [Model.Entity.ID](1...count)
    }
    
    private func saveErrorAndLeave(_ error: ApiError) {
        self.error = error
        self.dispatchGroup.leave()
    }
    
}
