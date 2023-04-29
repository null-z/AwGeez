//
//  Persistence.swift
//  Persistence
//
//  Created by Tony Dэ on 11.03.2023.
//

import Foundation
import Model

public typealias Persistence = OverallPersistence & EntitiesPersistence

public protocol OverallPersistence {
    var isFilled: Bool { get }
    func fillWith(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])
    func clear()
}

public protocol EntitiesPersistence {
    var character: any CharacterDao { get }
    var locaton: any LocationDao { get }
    var episode: any EpisodeDao { get }
}

public protocol CharacterDao: EntityDao where Entity == Model.Character { }
public protocol LocationDao: EntityDao where Entity == Model.Location { }
public protocol EpisodeDao: EntityDao where Entity == Model.Episode { }

public protocol EntityDao: AnyObject {
    associatedtype Entity: Model.Entity
    func readCount() -> Int
    func read(by id: Entity.ID) -> Entity
    func read(by ids: [Entity.ID]) -> [Entity]
}
