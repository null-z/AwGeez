//
//  RealmPersistence.swift
//  Persistence
//
//  Created by Tony Dэ on 11.03.2023.
//

import Foundation
import Model
import RealmSwift

class RealmPersistence: Persistence {
        
    var isFilled: Bool {
        let hasCharacters = character.readCount() > 0
        let hasLocations = locaton.readCount() > 0
        let hasEpisodes = episode.readCount() > 0
        let hasAllEntities = hasCharacters && hasLocations && hasEpisodes
        return hasAllEntities
    }
    
    func fillWith(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode]) {
        character.write(entities: characters)
        locaton.write(entities: locations)
        episode.write(entities: episodes)
    }
    
    func clear() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            fatalError("Failed to get Realm instance")
        }
    }
    
    var character: any CharacterDao = CharacterEntityDao()
    var locaton: any LocationDao = LocationEntityDao()
    var episode: any EpisodeDao = EpisodeEntityDao()
}
