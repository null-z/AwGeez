//
//  RequestHandler.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

protocol RequestHandler: AnyObject {
    func handleRequest<R: ResponseModel>(of type: R.Type, with pathPart: String, completion: @escaping (_: Result<R, ApiError>) -> Void)
}
