//
//  Character.swift
//  Api
//
//  Created by Tony Dэ on 09.01.2023.
//

import Foundation
import Model

extension Model.Character: ResponseModel {
    
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
        let type = try container.decode(String.self, forKey: .type)
        let gender = try container.decode(Self.Gender.self, forKey: .gender)
        
        let originContainer = try container.nestedContainer(keyedBy: LocationDecodingKeys.self, forKey: .origin)
        var originID: Model.Location.ID?
        if let originURL = try? originContainer.decode(URL.self, forKey: .url) {
            originID = Model.Location.ID(originURL.lastPathComponent)
            if originID == nil {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "no ID in URL " + originURL.absoluteString))
            }
        }
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationDecodingKeys.self, forKey: .location)
        let locationURL = try locationContainer.decode(URL.self, forKey: .url)
        guard let locationID = Model.Location.ID(locationURL.lastPathComponent) else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "no ID in URL " + locationURL.absoluteString))
        }
        
        let episodeURLs = try container.decode([URL].self, forKey: .episode)
        let episodeIDs = try episodeURLs.map { url in
            guard let result = Model.Episode.ID(url.lastPathComponent) else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "no ID in URL " + url.absoluteString))
            }
            return result
        }
        
        self.init(id: id, name: name, image: image, status: status, species: species, type: type, gender: gender, origin: originID, location: locationID, episodes: episodeIDs)
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
