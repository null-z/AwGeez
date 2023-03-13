//
//  Episode.swift
//  Persistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift
import Model

extension Model.Episode: Realmable {
    
    typealias RealmObject = EpisodeObject
    
    func realmObject() -> EpisodeObject {
        let realmObject = EpisodeObject()
        realmObject.id = Int(self.id)
        realmObject.season = Int(self.season)
        realmObject.number = Int(self.number)
        realmObject.name = self.name
        realmObject.airDate = self.airDate
        realmObject.characters = List(self.characters)
        return realmObject
    }
    
    init(with object: EpisodeObject) {
        let id = Self.ID(object.id)
        let season = UInt(object.season)
        let number = UInt(object.number)
        let name = object.name
        let airDate = object.airDate
        let characters = Array(object.characters)
        self.init(id: id, season: season, number: number, name: name, airDate: airDate, characters: characters)
    }
}
