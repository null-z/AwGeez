//
//  Episode.swift
//  Model
//
//  Created by Tony Dэ on 29.12.2022.
//

import Foundation

public struct Episode: Entity {
    public let id: ID
    public let season: UInt
    public let number: UInt
    public let name: String
    
    public let airDate: Date
    
    public let characters: [Character.ID]
    
    public init(id: ID, season: UInt, number: UInt, name: String, airDate: Date, characters: [Character.ID]) {
        self.id = id
        self.season = season
        self.number = number
        self.name = name
        self.airDate = airDate
        self.characters = characters
    }
}
