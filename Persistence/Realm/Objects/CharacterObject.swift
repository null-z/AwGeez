//
//  CharacterObject.swift
//  Persistence
//
//  Created by Tony Dэ on 12.03.2023.
//

import Foundation
import RealmSwift

final class CharacterObject: EntityObject {
    @Persisted var name = ""
    @Persisted var image = ""
    @Persisted var status = ""
    
    @Persisted var species = ""
    @Persisted var type: String?
    @Persisted var gender = ""
    
    @Persisted var origin: Int?
    @Persisted var location: Int?
    @Persisted var episodes: List<Int>
}
