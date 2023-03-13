//
//  RestApi.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model
import Macaroni

final class RestApi: Api {
    
    public init() { }
    
    public func getAll(completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>, failure: @escaping Failure) {
        self.getCounts(completion: { [weak self] counts in
            guard let self else { return }
            EntitiesFetcher(characterEndpoint: self.character,
                            locationEndpoint: self.location,
                            episodeEndpoint: self.episode)
                .getAll(by: counts, completion: completion, failure: failure)

        }, failure: failure)
    }
    
    func getCounts(completion: @escaping Completion<(characters: Count, locations: Count, episodes: Count)>, failure: @escaping Failure) {
        CountFetcher(characterEndpoint: character, locationEndpoint: location, episodeEndpoint: episode)
            .getCounts(completion: completion, failure: failure)
    }

    private(set) lazy var character: CharacterEndpoint = CharacterEndpoint(requestHandler: self)
    private(set) lazy var location: LocationEndpoint = LocationEndpoint(requestHandler: self)
    private(set) lazy var episode: EpisodeEndpoint = EpisodeEndpoint(requestHandler: self)
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    @Injected(.capturingContainerOnInit(container))
    private var requester: Requester
        
    init(character: CharacterEndpoint, location: LocationEndpoint, episode: EpisodeEndpoint) {
        self.character = character
        self.location = location
        self.episode = episode
    }
}

extension RestApi: RequestHandler {
    func handle<R>(request: Request<R>) where R: ResponseModel {
        request.path = basePath + request.path
        requester.handle(request: request)
    }
}
