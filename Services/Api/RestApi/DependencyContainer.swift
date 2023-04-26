//
//  DependencyContainer.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Swinject

var container: Container = {
    var container = Container()
    container.register(Requester.self) { _ in AlamofireRequester() }
    return container
}()
