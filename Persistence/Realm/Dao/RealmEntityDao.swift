//
//  RealmEntityDao.swift
//  Persistence
//
//  Created by Tony Dэ on 11.03.2023.
//

import Foundation
import Model
import RealmSwift

extension EntityDao where Entity: Realmable {
    
    func write(entities: [Entity]) {
        let objects = entities.map { $0.realmObject() }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects)
            }
        } catch {
            fatalError("Failed to get Realm instance")
        }
    }
        
    func readCount() -> Int {
        do {
            let realm = try Realm()
            let objects = realm.objects(Entity.RealmObject.self)
            return objects.count
        } catch {
            fatalError("Failed to get Realm instance")
        }
    }
    
    func read(by id: Entity.ID) -> Entity {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: Entity.RealmObject.self, forPrimaryKey: Int(id))
            guard let object = object else {
                fatalError("Failed to read object from Realm")
            }
            let entity = Entity(with: object)
            return entity
        } catch {
            fatalError("Failed to get Realm instance")
        }
    }
    
    func read(by ids: [Entity.ID]) -> [Entity] {
        let ids = ids.map { Int($0) }
        do {
            let realm = try Realm()
            let objects = realm.objects(Entity.RealmObject.self)
            let filteredObjects = objects.where {
                $0.id.in(ids)
            }
            let sortedObjects = filteredObjects.sorted(by: \.id, ascending: true)
            let entitiesResults = sortedObjects.map { Entity(with: $0) }
            let unwrappedEntities = Array(entitiesResults)
            return unwrappedEntities
        } catch {
            fatalError("Failed to get Realm instance")
        }
    }
}
