//
//  List+Array.swift
//  RealmPersistence
//
//  Created by Tony Dэ on 13.03.2023.
//

import Foundation
import RealmSwift
import Model

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
