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
    
    let path = "character/"
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func get(by ids: [Model.Character.ID], completion: @escaping ([Model.Character]) -> Void, failure: @escaping Failure) {
        let idsString = ids.map { id in
            String(id)
        }
            .joined(separator: ",")
        
        let request = Request(of: [Character].self, by: idsString, completion: { response in
            completion(response)
        }, failure: failure)
        
        self.handle(request: request)
    }
    
    func getCount(completion: @escaping Completion<UInt>, failure: @escaping Failure) {
        let request = Request(of: PaginatedResponse.self, completion: { response in
            completion(response.info.count)
        }, failure: failure)
        self.handle(request: request)
    }

}

extension CharacterEndpoint: RequestHandler {
    func handle<R>(request: Request<R>) where R: ResponseModel {
        request.path = path + request.path
        requestHandler.handle(request: request)
    }
}
