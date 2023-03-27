//
//  EpisodeObject.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift

final class EpisodeObject: EntityObject {
    @Persisted var season = 0
    @Persisted var number = 0
    @Persisted var name = ""
    @Persisted var airDate = Date()
    @Persisted var characters = List<Int>()
}
