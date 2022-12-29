//
//  Location.swift
//  Model
//
//  Created by Tony Dэ on 29.12.2022.
//

import Foundation

public struct Location: Entity {
    public let id: ID
    public let name: String
    
    public let type: String
    public let dimension: String
    
    public let residents: [Character.ID]
    
    public init(id: ID, name: String, type: String, dimension: String, residents: [Character.ID]) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
    }
}
