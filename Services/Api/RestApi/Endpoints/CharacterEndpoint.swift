//
//  CharacterEndpoint.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model

class CharacterEndpoint: EntityEndpoint<Model.Character> {
    
    override var path: String { "character/" }
}
