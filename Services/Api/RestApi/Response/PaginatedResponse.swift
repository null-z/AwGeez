//
//  PaginatedResponse.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

struct PaginatedResponse: ResponseModel {
    let info: Info
}

extension PaginatedResponse {
    struct Info: ResponseModel {
        let count: Count
    }
}
