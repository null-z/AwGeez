//
//  StartupConfigurator.swift
//  AwGeez
//
//  Created by Tony Dэ on 27.04.2023.
//

import Foundation

final class StartupConfigurator {
    
    static let `default` = StartupConfigurator.init()
    
    let needResetImageCache = false
    
    func configure() {
        registerDependecies()
        
        setupImageCache()
        resetCacheIfNeeded()
        setupAppearances()
    }
}
