//
//  MockRequester.swift
//  RestApiTests
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation
@testable import RestApi

class MockRequester: Requester {
    var jsonData: Data!
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        let responseModel = try! JSONDecoder().decode(R.self, from: jsonData)
        request.completion(responseModel)
    }
}
