//
//  EntityEndpoint.swift
//  RestApi
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation
import Model
import Api

class EntityEndpoint<Entity: Model.Entity & ResponseModel>: PathComposingEndpoint {
    
    func get(by ids: [Entity.ID], completion: @escaping ([Entity]) -> Void, failure: @escaping Failure) {
        let idsString = ids.map { id in
            String(id)
        }
            .joined(separator: ",")
        
        let request = Request(of: [Entity].self, by: idsString, completion: { response in
            completion(response)
        }, failure: failure)
        
        self.handle(request: request)
    }
    
    func getCount(completion: @escaping Completion<Count>, failure: @escaping Failure) {
        let request = Request(of: PaginatedResponse.self, completion: { response in
            completion(response.info.count)
        }, failure: failure)
        self.handle(request: request)
    }
}
