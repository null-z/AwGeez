//
//  RestApi.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Macaroni

class RestApi: Api {
    
    lazy var all: ApiAll = AllEndpoint()
    lazy var character: CharacterEndpoint = CharacterEndpoint(requestHandler: self)
    
    private let basePath = "https://rickandmortyapi.com/api"
    
    @Injected private var requester: Requester
        
}

extension RestApi: RequestHandler {
    func handleRequest<R>(of type: R.Type, with pathPart: String, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        let url = URL(string: basePath + pathPart)!
        requester.get(type, url: url, completion: completion)
    }
}
