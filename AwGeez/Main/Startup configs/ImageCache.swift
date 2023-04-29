//
//  ImageCache.swift
//  AwGeez
//
//  Created by Tony Dэ on 27.04.2023.
//

import Foundation
import Kingfisher

extension StartupConfigurator {
    
    func setupImageCache() {
        ImageCache.default.memoryStorage.config.countLimit = 100
        ImageCache.default.diskStorage.config.sizeLimit = 200 * 1024 * 1024 // 200 MB
    }

    func resetCacheIfNeeded() {
        if needResetImageCache {
            ImageCache.default.clearCache()
        }
    }
}
