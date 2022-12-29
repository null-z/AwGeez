//
//  Character.swift
//  Model
//
//  Created by Tony Dэ on 29.12.2022.
//

import Foundation

public struct Character: Entity {
    public let id: ID
    public let name: String
    public let image: URL
    
    public let status: Status
    
    public let species: String
    public let type: String?
    public let gender: Gender
    
    public let origin: Location.ID
    public let location: Location.ID
    public let episode: [Episode.ID]
    
    public init(id: ID, name: String, image: URL, status: Status, species: String, type: String?, gender: Gender, origin: Location.ID, location: Location.ID, episode: [Episode.ID]) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.episode = episode
    }
}

public extension Character {
    enum Status {
        case alive
        case dead
        case unknown
    }
}

public extension Character {
    enum Gender {
        case female
        case male
        case genderless
        case unknown
    }
}
