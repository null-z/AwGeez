//
//  Location.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift
import Model

extension Model.Location: Realmable {
    
    typealias RealmObject = LocationObject
    
    func realmObject() -> LocationObject {
        let realmObject = LocationObject()
        realmObject.id = Int(self.id)
        realmObject.name = self.name
        realmObject.type = self.type
        realmObject.dimension = self.dimension
        realmObject.residents = List(self.residents)
        return realmObject
    }
    
    init(with object: LocationObject) {
        let id = Self.ID(object.id)
        let name = object.name
        let type = object.type
        let dimension = object.dimension
        let residents = Array(object.residents)
        self.init(id: id, name: name, type: type, dimension: dimension, residents: residents)
    }
}
