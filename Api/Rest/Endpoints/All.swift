//
//  All.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model

class AllEndpoint: ApiAll {    
    func get(completion: @escaping (Result<([Model.Character], [Model.Location], [Model.Episode]), ApiError>) -> Void) {
    }
}
