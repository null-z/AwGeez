//
//  EpisodeEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation
import Model

class EpisodeEndpoint: EntityEndpoint<Model.Episode> {
    
    override var path: String { "episode/" }
}
