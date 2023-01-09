//
//  MockedData.swift
//  RestApiTests
//
//  Created by Tony Dэ on 07.01.2023.
//

import Foundation

final class MockedJsonData {
    
    static let character = jsonDataFromFile(withName: "character")
    static let characters = jsonDataFromFile(withName: "characters")
    static let charactersPage = jsonDataFromFile(withName: "charactersPage")
    
    private static func jsonDataFromFile(withName name: String) -> Data {
        let bundle = Bundle(for: MockedJsonData.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("Missing file: " + name + ".json")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Cannot convert data")
        }
        return data
    }

}
