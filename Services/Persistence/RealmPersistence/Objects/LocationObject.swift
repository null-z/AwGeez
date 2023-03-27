//
//  LocationObject.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift

final class LocationObject: EntityObject {
    @Persisted var name = ""
    @Persisted var type = ""
    @Persisted var dimension = ""
    @Persisted var residents: List<Int>
}
