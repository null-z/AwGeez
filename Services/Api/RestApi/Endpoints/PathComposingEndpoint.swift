//
//  PathComposingEndpoint.swift
//  RestApi
//
//  Created by Tony Dэ on 12.01.2023.
//

import Foundation

class PathComposingEndpoint: RequestHandler {
    
    var path: String { "" }
    
    unowned let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        request.path = path + request.path
        requestHandler.handle(request: request)
    }
}
