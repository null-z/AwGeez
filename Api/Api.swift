//
//  Api.swift
//  Api
//
//  Created by Tony Dэ on 05.01.2023.
//

import Foundation
import Model

public typealias Completion<R> = (R) -> Void
public typealias Failure = (ApiError) -> Void

public protocol Api {
    var all: ApiAll { get }
}

public protocol ApiAll {
    func get(completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>, failure: @escaping Failure)
}
