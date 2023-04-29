//
//  ProcessInfo.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.03.2023.
//

import Foundation

extension ProcessInfo {
    var isTestRun: Bool {
        isArgumentsContains("-isTestRun")
    }
    
    private func isArgumentsContains(_ argument: String) -> Bool {
        arguments.contains { $0 == argument }
    }
}
