//
//  Character.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 12.03.2023.
//

import Foundation
import RealmSwift
import Model

extension Model.Character: Realmable {
    
    typealias RealmObject = CharacterObject
    
    func realmObject() -> CharacterObject {
        let realmObject = CharacterObject()
        realmObject.id = Int(self.id)
        realmObject.name = self.name
        realmObject.image = self.image.absoluteString
        realmObject.status = self.status.rawValue
        realmObject.species = self.species
        realmObject.type = self.type
        realmObject.gender = self.gender.rawValue
        realmObject.origin = Int(self.origin)
        realmObject.location = Int(self.location)
        realmObject.episodes = List(self.episodes)
        return realmObject
    }

    init(with object: CharacterObject) {
        let id = Self.ID(object.id)
        let name = object.name
        let image = URL(string: object.image)!
        let status = Self.Status(rawValue: object.status)!
        let species = object.species
        let type = object.type
        let gender = Self.Gender(rawValue: object.gender)!
        let origin = Self.ID(object.origin)
        let location = Self.ID(object.location)
        let episode = Array(object.episodes)
        
        self.init(id: id, name: name, image: image, status: status, species: species, type: type, gender: gender, origin: origin, location: location, episodes: episode)
    }
}
