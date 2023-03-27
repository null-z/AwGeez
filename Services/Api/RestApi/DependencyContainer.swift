//
//  DependencyContainer.swift
//  RestApi
//
//  Created by Tony Dэ on 06.01.2023.
//

import Foundation
import Macaroni

var container: Container = {
    var container = Container(parent: nil, name: "RestApi")
    Macaroni.logger = LoggerStub()
    Container.lookupPolicy = .singleton(container)
    container.register { () -> Requester in AlamofireRequester() }
    return container
}()

private class LoggerStub: MacaroniLogger {
    func log(_ message: String, level: MacaroniLoggingLevel, file: StaticString, function: String, line: UInt) {
    }

    func die(_ message: String, file: StaticString, function: String, line: UInt) -> Never {
        abort()
    }
}
