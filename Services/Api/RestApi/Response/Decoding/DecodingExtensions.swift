//
//  DecodingExtensions.swift
//  RestApi
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation
import Model

extension KeyedDecodingContainer {
    func decodeIdsFormUrls(forKey key: K) throws -> [Model.Entity.ID] {
        let urls = try self.decode([URL].self, forKey: key)
        let ids = try urls.map { url in
            let id = try self.id(from: url)
            return id
        }
        return ids
    }
    
    func decodeIdFromUrl(forKey key: K) throws -> Model.Entity.ID {
        let url = try self.decode(URL.self, forKey: key)
        let id = try self.id(from: url)
        return id
    }
    
    private func id(from url: URL) throws -> Model.Entity.ID {
        guard let id = Model.Entity.ID(url.lastPathComponent) else {
            throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "no ID in URL " + url.absoluteString))
        }
        return id
    }
}

extension String {
    func nullifyIfEmpty() -> Self? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
}
