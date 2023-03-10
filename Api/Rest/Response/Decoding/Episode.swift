//
//  Episode.swift
//  Api
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation
import Model

extension Model.Episode: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case id
        case name
        case air_date // swiftlint:disable:this identifier_name
        case episode
        case characters
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let id = try container.decode(Self.ID.self, forKey: .id)
        let episode = try container.decodeSeasonAndNumber(forKey: .episode)
        let name = try container.decode(String.self, forKey: .name)
        let airDate = try container.decodeAirDate(forKey: .air_date)
        let characters = try container.decodeIdsFormUrls(forKey: .characters)
        
        self.init(id: id, season: episode.season, number: episode.number, name: name, airDate: airDate, characters: characters)
    }
}

fileprivate extension KeyedDecodingContainer {
    func decodeSeasonAndNumber(forKey key: K) throws -> (season: UInt, number: UInt) {
        let episode = try self.decode(String.self, forKey: key)
        let set = CharacterSet(["S", "E"])
        let subStrings = episode.components(separatedBy: set)
        let numbers = subStrings.compactMap { string in UInt(string) }
        guard let season = numbers.first,
              let number = numbers.last else {
            throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "failed extract numbers from " + episode))
        }
        return (season, number)
    }
}

fileprivate extension DateFormatter {
    static let airDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
}

fileprivate extension KeyedDecodingContainer {
    func decodeAirDate(forKey key: K) throws -> Date {
        let dateString = try self.decode(String.self, forKey: key)
        guard let date = DateFormatter.airDateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "failed decode date from " + dateString))
        }
        return date
    }
}
