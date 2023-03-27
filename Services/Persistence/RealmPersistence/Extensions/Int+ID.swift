//
//  Int+ID.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import Model

extension Int {
    init?(_ id: Model.Entity.ID?) {
        if let id = id {
            self = Self(id)
        } else {
            return nil
        }
    }
}

extension Model.Entity.ID {
    init?(_ number: Int?) {
        if let number = number {
            self = Self(number)
        } else {
            return nil
        }
    }
}
