//
//  EpisodeEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation
import Model

final class EpisodeEndpoint: Endpoint, EntityEndpoint {
    
    typealias Entity = Model.Episode
    
    override var path: String { "episode/" }
}
