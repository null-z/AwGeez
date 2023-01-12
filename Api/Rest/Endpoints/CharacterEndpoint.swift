//
//  CharacterEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model

final class CharacterEndpoint: Endpoint, EntityEndpoint {
    
    typealias Entity = Model.Character
    
    override var path: String { "character/" }
}
