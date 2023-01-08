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
    
    func get(by ids: [Model.Character.ID], completion: @escaping (Result<Model.Character, ApiError>) -> Void) {
        let idsString = ids.map { id in
            String(id)
        }
            .joined(separator: ",")
        
        self.handleRequest(of: Example.self, with: idsString) { _ in }
    }
    
    func getCount(completion: @escaping (Result<UInt, ApiError>) -> Void) {
        self.handleRequest(of: PaginatedResponse.self, with: "") { result in
            switch result {
            case .success(let response):
                let count = response.info.count
                completion(Result.success(count))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
        
}

extension CharacterEndpoint: RequestHandler {
    
    func handleRequest<R>(of type: R.Type, with pathPart: String, completion: @escaping (Result<R, ApiError>) -> Void) where R: ResponseModel {
        let path = path + "/" + pathPart
        requestHandler.handleRequest(of: type, with: path, completion: completion)
    }
}
