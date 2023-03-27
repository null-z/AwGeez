//
//  AlamofireRequester.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Alamofire

final class AlamofireRequester: Requester {
    
    private let reachibilityManager = NetworkReachabilityManager()
    
    func handle<R>(request: Request<R>) where R: ResponseModel {
        if !(reachibilityManager?.isReachable ?? false) {
            print("Network connection failure")
            request.failure(.badConnection)
            return
        }
        
        guard let url = URL(string: request.path) else {
            print("Request path to URL conversion failure")
            request.failure(.badResponse)
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: request.modelType) { response in
                switch response.result {
                case .success(let responseModel):
                    request.completion(responseModel)
                case .failure:
                    request.failure(.badResponse)
                }
            }

    }
}
