//
//  Persistence.swift
//  Persistence
//
//  Created by Tony Dэ on 11.03.2023.
//

import Foundation
import Model

public protocol Persistence {
    
    var isFilled: Bool { get }

    func saveAll(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])
    func deleteAll()
        
    var character: any CharacterDao { get }
    var locaton: any LocationDao { get }
    var episode: any EpisodeDao { get }
}

public protocol CharacterDao: EntityDao where Entity == Model.Character { }
public protocol LocationDao: EntityDao where Entity == Model.Location { }
public protocol EpisodeDao: EntityDao where Entity == Model.Episode { }

public protocol EntityDao: AnyObject {
    associatedtype Entity: Model.Entity
    func read(by id: Entity.ID) -> Entity
    func read(by ids: [Entity.ID]) -> [Entity]
}
