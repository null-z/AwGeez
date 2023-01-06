//
//  CharacterEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Model

class CharacterEndpoint {
    
    private let requestHandler: RequestHandler
    
    let path = "/character"
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func get(by id: Model.Character.ID, completion: @escaping (Result<Model.Character, ApiError>) -> Void) {
        self.handleRequest(of: Example.self, with: String(id)) { _ in }
    }
    
    func get(by ids: [Model.Character.ID], completion: @escaping (Result<Model.Character, ApiError>) -> Void) {
        let idsString = ids.map { id in
            String(id)
        }
            .joined(separator: ",")
        
        self.handleRequest(of: Example.self, with: idsString) { _ in }
    }
        
}

extension CharacterEndpoint: RequestHandler {
    
    func handleRequest<R>(of type: R.Type, with pathPart: String, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        let path = path + "/" + pathPart
        requestHandler.handleRequest(of: type, with: path, completion: completion)
    }
}
