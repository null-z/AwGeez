//
//  ResponseModel.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

protocol ResponseModel: Decodable { }

extension UInt: ResponseModel { }

struct Example: ResponseModel { }
