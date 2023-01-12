//
//  CountFetcher.swift
//  Api
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation

class CountFetcher {
    
    let characterEndpoint: CharacterEndpoint
    let locationEndpoint: LocationEndpoint
    let episodeEndpoint: EpisodeEndpoint
    
    init(characterEndpoint: CharacterEndpoint, locationEndpoint: LocationEndpoint, episodeEndpoint: EpisodeEndpoint) {
        self.characterEndpoint = characterEndpoint
        self.locationEndpoint = locationEndpoint
        self.episodeEndpoint = episodeEndpoint
    }
    
    var dispatchGroup = DispatchGroup()
    
    var characters: Count?
    var locations: Count?
    var episodes: Count?
    
    var error: ApiError?

    func getCounts(completion: @escaping Completion<(characters: Count, locations: Count, episodes: Count)>, failure: @escaping Failure) {
        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()
        
        characterEndpoint.getCount { count in
            self.characters = count
            self.dispatchGroup.leave()
        } failure: { error in
            self.error = error
            self.dispatchGroup.leave()
        }
        
        locationEndpoint.getCount { count in
            self.locations = count
            self.dispatchGroup.leave()
        } failure: { error in
            self.error = error
            self.dispatchGroup.leave()
        }
        
        episodeEndpoint.getCount { count in
            self.episodes = count
            self.dispatchGroup.leave()
        } failure: { error in
            self.error = error
            self.dispatchGroup.leave()
        }
        
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
    
    deinit {
        let message = """
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
CountFetcher deinit
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
"""
        print(message)
    }
}
