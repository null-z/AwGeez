//
//  DependencyContainer.swift
//  Api
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Macaroni

var container: Container = {
    var container = Container(parent: nil, name: "RestApi")
    Container.lookupPolicy = .singleton(container)
    container.register { () -> Requester in AlamofireRequester() }
    return container
}()
