//
//  ConversionExtensions.swift
//  Persistence
//
//  Created by Tony Dэ on 12.03.2023.
//

import Foundation
import RealmSwift
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

extension List where Element == Int {
    convenience init(_ ids: [Model.Entity.ID]) {
        self.init()
        let convertedIds = ids.map { Int($0) }
        self.append(objectsIn: convertedIds)
    }
}

extension Array where Element == Model.Entity.ID {
    init(_ ids: List<Int>) {
        self = ids.map { Element($0) }
    }
}
