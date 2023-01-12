//
//  Location.swift
//  Api
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation
import Model

extension Model.Location: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let id = try container.decode(Self.ID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let type = try container.decode(String.self, forKey: .type)
        let dimension = try container.decode(String.self, forKey: .dimension)
        let residentIDs = try container.decodeIdsFormUrls(forKey: .residents)
        
        self.init(id: id, name: name, type: type, dimension: dimension, residents: residentIDs)
    }
}
