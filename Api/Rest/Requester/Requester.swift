//
//  Requester.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

protocol Requester: AnyObject {
            
    func get<R: ResponseModel>(_ type: R.Type, url: URL, completion: @escaping (_: Result<R, ApiError>) -> Void)

}
