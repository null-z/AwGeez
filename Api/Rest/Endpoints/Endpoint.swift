//
//  Endpoint.swift
//  Api
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation

class Endpoint: RequestHandler {
    
    var path: String { "" }
    
    let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        request.path = path + request.path
        requestHandler.handle(request: request)
    }
}
