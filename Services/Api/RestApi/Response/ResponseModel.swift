//
//  ResponseModel.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation

protocol ResponseModel: Decodable { }

typealias Count = UInt
extension Count: ResponseModel { }

extension Array: ResponseModel where Element: ResponseModel { }

import Model

extension Model.Character: ResponseModel { }
extension Model.Location: ResponseModel { }
extension Model.Episode: ResponseModel { }
