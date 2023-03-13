//
//  EntityObject.swift
//  Persistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift

class EntityObject: Object {
    @Persisted(primaryKey: true) var id = 0
}
