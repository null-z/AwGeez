//
//  AlamofireRequester.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Alamofire

class AlamofireRequester: Requester {
    
    private let reachibilityManager = NetworkReachabilityManager()
        
    func get<R: ResponseModel>(_ type: R.Type, url: URL, completion: @escaping (_: Result<R, ApiError>) -> Void) {
        if !(reachibilityManager?.isReachable ?? false) {
            completion(.failure(.badConnection))
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let responseModel):
                    completion(.success(responseModel))
                case .failure:
                    completion(.failure(.badResponse))
                }
            }
    }
}
