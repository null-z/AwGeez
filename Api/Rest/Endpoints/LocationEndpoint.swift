//
//  LocationEndpoint.swift
//  Api
//
//  Created by Tony Dэ on 11.01.2023.
//

import Foundation
import Model

class LocationEndpoint: EntityEndpoint<Model.Location> {
    
    override var path: String { "location/" }
}
