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
    
    private let basePath = "https://rickandmortyapi.com/api/"
    
    @Injected(.capturingContainerOnInit(container))
    private var requester: Requester
        
}

extension RestApi: RequestHandler {
    func handle<R>(request: Request<R>) where R: ResponseModel {
        request.path = basePath + request.path
        requester.handle(request: request)
    }
}
