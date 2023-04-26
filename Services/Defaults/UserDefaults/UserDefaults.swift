//
//  UserDefaults.swift
//  AwGeez
//
//  Created by Tony Dэ on 23.04.2023.
//

import Foundation

extension UserDefaults: Defaults {
    
    private enum Keys {
        static let lastUpdateDate = "lastUpdateDate"
    }

    public var lastUpdateDate: Date? {
        get {
            Date(timeIntervalSince1970: self.double(forKey: Keys.lastUpdateDate))
        }
        set {
            self.set(newValue?.timeIntervalSince1970, forKey: Keys.lastUpdateDate)
        }
    }
}
