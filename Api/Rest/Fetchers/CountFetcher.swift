//
//  CountFetcher.swift
//  Api
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation

final class CountFetcher {
    
    private let characterEndpoint: CharacterEndpoint
    private let locationEndpoint: LocationEndpoint
    private let episodeEndpoint: EpisodeEndpoint
    
    init(characterEndpoint: CharacterEndpoint, locationEndpoint: LocationEndpoint, episodeEndpoint: EpisodeEndpoint) {
        self.characterEndpoint = characterEndpoint
        self.locationEndpoint = locationEndpoint
        self.episodeEndpoint = episodeEndpoint
    }
    
    private var dispatchGroup = DispatchGroup()
    
    private var characters: Count?
    private var locations: Count?
    private var episodes: Count?
    
    private var error: ApiError?

    func getCounts(completion: @escaping Completion<(characters: Count, locations: Count, episodes: Count)>, failure: @escaping Failure) {
        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()
        
        characterEndpoint.getCount(completion: { count in
            self.characters = count
            self.dispatchGroup.leave()
        }, failure: saveErrorAndLeave(_:))

        locationEndpoint.getCount(completion: { count in
            self.locations = count
            self.dispatchGroup.leave()
        }, failure: saveErrorAndLeave(_:))

        episodeEndpoint.getCount(completion: { count in
            self.episodes = count
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
    
    private func saveErrorAndLeave(_ error: ApiError) {
        self.error = error
        self.dispatchGroup.leave()
    }
}
