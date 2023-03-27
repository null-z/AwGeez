//
//  Character.swift
//  RestApi
//
//  Created by Tony Dэ on 09.01.2023.
//

import Foundation
import Model

extension Model.Character: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
    }
    
    enum LocationDecodingKeys: String, CodingKey {
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let id = try container.decode(Self.ID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let image = try container.decode(URL.self, forKey: .image)
        let status = try container.decode(Self.Status.self, forKey: .status)
        let species = try container.decode(String.self, forKey: .species)
        let type = (try container.decode(String.self, forKey: .type)).nullifyIfEmpty()
        let gender = try container.decode(Self.Gender.self, forKey: .gender)
                
        let originContainer = try container.nestedContainer(keyedBy: LocationDecodingKeys.self, forKey: .origin)
        let originID = try? originContainer.decodeIdFromUrl(forKey: .url)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationDecodingKeys.self, forKey: .location)
        let locationID = try? locationContainer.decodeIdFromUrl(forKey: .url)
        
        let episodesIDs = try container.decodeIdsFormUrls(forKey: .episode)
        
        self.init(id: id, name: name, image: image, status: status, species: species, type: type, gender: gender, origin: originID, location: locationID, episodes: episodesIDs)
    }
}

extension Model.Character.Status: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let result = Self.init(rawValue: rawValue.lowercased()) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "lowercased rawValue is " + rawValue.lowercased()))
        }
        self = result
    }
}

extension Model.Character.Gender: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let result = Self.init(rawValue: rawValue.lowercased()) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "lowercased rawValue is " + rawValue.lowercased()))
        }
        self = result
    }
}
