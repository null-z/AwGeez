//
//  RequestHandler.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

protocol RequestHandler: AnyObject {
    func handle<R>(request: Request<R>)
}

final class Request<Model: ResponseModel> {
    
    let modelType: Model.Type
    
    var path: String
    
    let completion: (Model) -> Void
    let failure: (ApiError) -> Void
    
    init(of type: Model.Type, by path: String = "", completion: @escaping Completion<Model>, failure: @escaping Failure) {
        self.modelType = type
        self.path = path
        self.completion = completion
        self.failure = failure
    }

}
