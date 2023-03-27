//
//  Realmable.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 12.03.2023.
//

import Foundation
import RealmSwift
import Model

protocol Realmable {
    associatedtype RealmObject: EntityObject
    
    func realmObject() -> RealmObject
    init(with object: RealmObject)
}
