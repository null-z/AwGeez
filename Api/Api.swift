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
    func getAll(completion: @escaping Completion<(characters: [Model.Character], locations: [Model.Location], episodes: [Model.Episode])>, failure: @escaping Failure)
}
