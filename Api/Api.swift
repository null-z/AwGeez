//
//  Api.swift
//  Api
//
//  Created by Tony Dэ on 05.01.2023.
//

import Foundation
import Model

public protocol Api {
    var all: ApiAll { get }
}

public protocol ApiAll {
    func get(completion: @escaping (Result<([Character], [Location], [Episode]), ApiError>) -> Void)
}
